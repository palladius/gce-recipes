/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.google.cloud.pso;

import com.google.api.services.bigquery.model.TableRow;
import com.google.cloud.pso.DataUtils.CombinePixelValue;
import com.google.cloud.pso.data.*;
import com.google.logging.v2.LogEntry;
import org.apache.beam.runners.dataflow.DataflowRunner;
import org.apache.beam.runners.dataflow.options.DataflowPipelineOptions;
import org.apache.beam.sdk.Pipeline;
import org.apache.beam.sdk.coders.AvroCoder;
import org.apache.beam.sdk.extensions.gcp.options.GcpOptions;
import org.apache.beam.sdk.io.AvroIO;
import org.apache.beam.sdk.io.FileBasedSink.FilenamePolicy;
import org.apache.beam.sdk.io.TextIO;
import org.apache.beam.sdk.io.fs.ResolveOptions.StandardResolveOptions;
import org.apache.beam.sdk.io.fs.ResourceId;
import org.apache.beam.sdk.io.gcp.bigquery.BigQueryIO;
import org.apache.beam.sdk.io.gcp.bigquery.BigQueryIO.Write.CreateDisposition;
import org.apache.beam.sdk.io.gcp.bigquery.BigQueryIO.Write.WriteDisposition;
import org.apache.beam.sdk.io.gcp.pubsub.PubsubIO;
import org.apache.beam.sdk.io.gcp.pubsub.PubsubOptions;
import org.apache.beam.sdk.options.Default;
import org.apache.beam.sdk.options.DefaultValueFactory;
import org.apache.beam.sdk.options.Description;
import org.apache.beam.sdk.options.PipelineOptions;
import org.apache.beam.sdk.options.PipelineOptionsFactory;
import org.apache.beam.sdk.options.Validation;
import org.apache.beam.sdk.transforms.Combine;
import org.apache.beam.sdk.transforms.DoFn;
import org.apache.beam.sdk.transforms.ParDo;
import org.apache.beam.sdk.transforms.Sum;
import org.apache.beam.sdk.transforms.windowing.*;
import org.apache.beam.sdk.values.KV;
import org.apache.beam.sdk.values.PCollection;
import org.joda.time.Duration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.joda.time.Instant;

// See https://github.com/GoogleCloudPlatform/processing-logs-using-dataflow/blob/master/dataflow/src/main/java/com/google/cloud/solutions/LogAnalyticsPipeline.java


/**
 * A starter example for writing Beam programs.
 *
 * <p>The example takes two strings, converts them to their upper-case
 * representation and logs them.
 *
 * <p>To run this starter example locally using DirectRunner, just
 * execute it without any additional parameters from your favorite development
 * environment.
 *
 * <p>To run this starter example using managed resource in Google Cloud
 * Platform, you should specify the following command-line options:
 * --project=<YOUR_PROJECT_ID>
 * --stagingLocation=<STAGING_LOCATION_IN_CLOUD_STORAGE>
 * --runner=DataflowRunner
 */
public class StarterPipeline {

  public enum PipelineType {
    LogParser,
    GitCommitSummary
  }

  private static final Logger LOG = LoggerFactory.getLogger(StarterPipeline.class);

  public interface StarterPipelineOptions extends DataflowPipelineOptions, PubsubOptions {

    @Description("Pub/Sub topic")
    @Default.InstanceFactory(PubsubTopicFactory.class)
    String getPubsubTopic();
    void setPubsubTopic(String topic);

    /**
     * Returns a default Pub/Sub topic based on the project and the job names.
     */
    class PubsubTopicFactory implements DefaultValueFactory<String> {

      @Override
      public String create(PipelineOptions options) {
        return "projects/" + options.as(GcpOptions.class).getProject()
            + "/topics/" + options.getJobName();
      }
    }

    @Description("Pipeline to run")
    @Validation.Required()
    PipelineType getPipelineType();
    void setPipelineType(PipelineType pipelineType);

    @Description("Output prefix to GCS")
    @Validation.Required(groups = "output")
    String getOutputPrefix();
    void setOutputPrefix(String prefix);

    @Description("Output prefix to BigQuery Table")
    @Validation.Required(groups = "output")
    String getOutputTable();
    void setOutputTable(String table);

    @Description("Input from Google Query")
    @Validation.Required(groups = "input")
    String getInputQuery();
    void setInputQuery(String query);

    @Description("Input from GCS")
    @Validation.Required(groups = "input")
    String getInputFiles();
    void setInputFiles(String files);
  }

  private static class WindowedFilenamePolicy extends FilenamePolicy {
    @Override
    public ResourceId windowedFilename(ResourceId resourceId, WindowedContext windowedContext,
                                       String s) {
      return resourceId.resolve("output-s" + Long.toString(windowedContext.getWindow().maxTimestamp().getMillis()/1000) + "-" + windowedContext.getShardNumber() + "@" + windowedContext.getNumShards(),
              StandardResolveOptions.RESOLVE_FILE);
    }

    @Override
    public ResourceId unwindowedFilename(ResourceId resourceId, Context context, String s) {
      return resourceId.resolve("output-" + context.getShardNumber() + "@" + context.getNumShards(),
          StandardResolveOptions.RESOLVE_FILE);
    }
  }

  private static void LogParsing(StarterPipelineOptions options, Pipeline p) {
    // Register all codersa
    p.getCoderRegistry().registerCoderForClass(PixelAttr.class, AvroCoder.of(PixelAttr.class));
    p.getCoderRegistry().registerCoderForClass(PixelValue.class, AvroCoder.of(PixelValue.class));
    p.getCoderRegistry().registerCoderForClass(PixelSummaryStat.class, AvroCoder.of(PixelSummaryStat.class));


    PCollection<String> rawData;
    if (options.isStreaming()) {
      rawData = p.apply("ReadFromPubSub", PubsubIO.readStrings().fromTopic(options.getPubsubTopic()));
    }
    else {
      rawData = p.apply( "ReadFromTextFiles", TextIO.read().from(options.getInputFiles()));
    }

    // Convert to LogEntry objects
    PCollection<LogEntry> logEntries = rawData
            .apply("ConvertToLogEntry", ParDo.of(new DataUtils.JSONToLogEntry()));

    // If streaming, then add some windows
    if (options.isStreaming()) {
      logEntries = logEntries
              .apply("WindowFixed", Window.<LogEntry>into(FixedWindows.of(Duration.standardSeconds(10))));
    }

    // Get the normalized windowed entries from pubsub
    PCollection<PixelSummaryStat> grouped = logEntries
            .apply("ConvertToKeyValue", ParDo.of(new DoFn<LogEntry, KV<PixelAttr, PixelValue>>() {
              @ProcessElement
              public void processElement(ProcessContext c, BoundedWindow window) {
                // Should set the timestamp to the nearest hour or whatever you want to aggregate by --
                // these aggregates can be accumulated later as well, so we can handle late data just fine.
                KV<PixelAttr, PixelValue> stat = DataUtils.newPixel2KV(c.element());
                if (stat != null) {
                  LOG.info("Converted into key/value prior to grouping: " + stat.toString());
                  c.output(stat);
                }
              }
            }))
            .apply("CombineByKey", Combine.perKey(new CombinePixelValue()))
            .apply("NormalizeIntoAvro", ParDo.of(new DoFn<KV<PixelAttr, PixelValue>, PixelSummaryStat>() {
              @ProcessElement
              public void processElement(ProcessContext c) {
                LOG.info("Normalizing into Avro...");
                PixelSummaryStat output = new PixelSummaryStat(c.element().getKey(), c.element().getValue());
                LOG.info("Output after combination:" + output.toString());
                c.output(output);
              }
            }));

    // Dump to Cloud Storage
    if (options.getOutputPrefix() != null) {
      grouped.apply(
              "WriteToGCS",
              AvroIO.write(PixelSummaryStat.class)
                      .to(options.getOutputPrefix())
                      .withWindowedWrites()               // should only use when streaming
                      .withNumShards(1)
                      .withFilenamePolicy(new WindowedFilenamePolicy())
      );
    }

    // Dump to BigQuery
    if (options.getOutputTable() != null) {
      grouped.apply(
              "WriteToBigQuery",
              ParDo.of(new AvroToBigQuery<PixelSummaryStat>()))
              .apply(BigQueryIO.writeTableRows()
                      .to(options.getOutputTable())
                      .withCreateDisposition(CreateDisposition.CREATE_IF_NEEDED)
                      .withWriteDisposition(WriteDisposition.WRITE_TRUNCATE)
                      .withSchema(AvroToBigQuery.getTableSchemaRecord(PixelSummaryStat.getClassSchema())));
    }
  }

  public static void GitCommitParser(StarterPipelineOptions options, Pipeline p) {

    // Register all coders
    p.getCoderRegistry().registerCoderForClass(GitCommitRecord.class, AvroCoder.of(GitCommitRecord.class));
    p.getCoderRegistry().registerCoderForClass(GitCommitTop.class, AvroCoder.of(GitCommitTop.class));

    PCollection<KV<String, Long>> rawData;

    // Get the data from a query, or avro files...
    if (options.getInputQuery() != null) {
      rawData = p.apply("ReadFromBigQuery", BigQueryIO.read().fromQuery(options.getInputQuery()))
              .apply("ConvertToKeyValue", ParDo.of(new DoFn<TableRow, KV<String,Long>>() {
                @ProcessElement
                public void processElement(ProcessContext c) {
                  c.output(KV.of((String)c.element().get("email"), (long)1));
                }
              }));
    }
    else {
      rawData = p.apply("ReadFromAvroFiles", AvroIO.read(GitCommitRecord.class).from(options.getInputFiles()))
              .apply("ConvertToKeyValue", ParDo.of(new DoFn<GitCommitRecord, KV<String, Long>>() {
                @ProcessElement
                public void processElement(ProcessContext c, BoundedWindow window) {
                  c.output(KV.of(
                          c.element().getAuthor().getEmail().toString(),
                          (long)1));
                }
              }));
    }

    // Get the normalized windowed entries from pubsub
    PCollection<GitCommitTop> grouped = rawData
            .apply("CombineByKey", Sum.<String>longsPerKey())
            .apply("NormalizeIntoAvro", ParDo.of(new DoFn<KV<String, Long>, GitCommitTop>() {
              @ProcessElement
              public void processElement(ProcessContext c) {
                c.output(new GitCommitTop(c.element().getKey(), c.element().getValue()));
              }
            }));

    // Dump to Cloud Storage
    if (options.getOutputPrefix() != null) {
      grouped.apply(
              "WriteToGCS",
              AvroIO.write(GitCommitTop.class)
                      .to(options.getOutputPrefix())
                      .withWindowedWrites()
                      .withNumShards(1)
                      .withFilenamePolicy(new WindowedFilenamePolicy())
      );
    }

    // Dump to BigQuery
    if (options.getOutputTable() != null) {
      grouped.apply(
              "ConvertToBigQuery",
              ParDo.of(new AvroToBigQuery<GitCommitTop>()))
              .apply("WriteToBigQuery", BigQueryIO.writeTableRows()
                      .to(options.getOutputTable())
                      .withCreateDisposition(CreateDisposition.CREATE_IF_NEEDED)
                      .withWriteDisposition(WriteDisposition.WRITE_TRUNCATE)
                      .withSchema(AvroToBigQuery.getTableSchemaRecord(PixelSummaryStat.getClassSchema())));
    }
  }

  public static void main(String[] args) {


    LOG.info("Starting StarterPipeline version " + StarterPipeline.class.getPackage().getImplementationVersion());

    PipelineOptionsFactory.register(StarterPipelineOptions.class);
    StarterPipelineOptions options = PipelineOptionsFactory.fromArgs(args)
        .withValidation()
        .as(StarterPipelineOptions.class);

    Pipeline p = Pipeline.create(options);

    // Fill in the pipeline
    if (options.getPipelineType().equals(PipelineType.LogParser)) {
      LogParsing(options, p);
    }
    else if (options.getPipelineType().equals(PipelineType.GitCommitSummary)) {
      GitCommitParser(options, p);
    }

    // Run everything
    p.run();
  }
}
