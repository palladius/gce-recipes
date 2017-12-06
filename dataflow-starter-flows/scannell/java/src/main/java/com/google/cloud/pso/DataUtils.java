package com.google.cloud.pso;

import com.google.cloud.pso.data.PixelAttr;
import com.google.cloud.pso.data.PixelValue;
import com.google.logging.v2.LogEntry;
import com.google.protobuf.InvalidProtocolBufferException;
import com.google.protobuf.util.JsonFormat;
import io.netty.handler.codec.http.QueryStringDecoder;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Map;

import org.apache.beam.sdk.transforms.DoFn;
import org.apache.beam.sdk.transforms.SerializableFunction;
import org.apache.beam.sdk.values.KV;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by scannell on 10/10/17.
 */
public class DataUtils {
  private static final Logger LOG = LoggerFactory.getLogger(DataUtils.class);

  /*
   * Parse the LogEntry from JSON - a generic step
   */
  static class JSONToLogEntry extends DoFn<String,LogEntry> {
    private JsonFormat.Parser parse;
    private LogEntry.Builder builder;

    @StartBundle
    public void startBundle() {
      parse = JsonFormat.parser();
      builder = LogEntry.newBuilder();
    }

    @ProcessElement
    public void processElement(ProcessContext c) {
      try {
        builder.clear();
        parse.merge(c.element(), builder);
        c.outputWithTimestamp(builder.build(), c.timestamp());
      } catch (InvalidProtocolBufferException e) {
        e.printStackTrace();
      }
    }
  }

  static String getParam(Map<String,List<String>> params, String param) {
    List<String> vals = params.get(param);
    if (vals == null || vals.size() == 0) {
      return "";
    }
    return vals.get(0);
  }

  static Double getDoubleParam(Map<String,List<String>> params, String param) {
    List<String> vals = params.get(param);
    if (vals == null || vals.size() == 0) {
      return 0.0;
    }
    try {
      return Double.parseDouble(vals.get(0));
    } catch (NumberFormatException e) {
      return 0.0;
    }
  }


  /*
   * Create a new PixelAttr and PixelValue from a LogEntry
   */
  public static KV<PixelAttr,PixelValue> newPixel2KV(LogEntry entry) {
    try {
      long timestamp = (entry.getTimestamp().getSeconds()/3600)*3600*1000;
      URL url = new URL(entry.getHttpRequest().getRequestUrl());
      if (url.getQuery() == null) {
        LOG.info("URL with no parameters!");
        return KV.of(
            new PixelAttr(
                timestamp,
                url.getHost(),
                url.getPath(),
                "",
                "",
                ""
            ),
            new PixelValue(
                0.0,
                (long)1
            )
        );
      }
      QueryStringDecoder qsd = new QueryStringDecoder(url.getQuery(), false);
      if (qsd == null) {
        LOG.warn("Can't get StringDecoder from: ", url.getQuery());
        return null;
      }
      Map<String,List<String>> params = qsd.parameters();
      return KV.of(
          new PixelAttr(
              timestamp,
              url.getHost(),
              url.getPath(),
              getParam(params, "sessionId"),
              getParam(params, "pageId"),
              getParam(params, "section")
          ),
          new PixelValue(
              getDoubleParam(params, "value"),
              (long)1
          )
      );
    } catch (MalformedURLException e) {
      e.printStackTrace();
    }
    return null;
  }

  /*
   * Combine together a list of PixelValue for aggregation purposes
   */
  static class CombinePixelValue implements SerializableFunction<Iterable<PixelValue>,PixelValue> {
    @Override
    public PixelValue apply(Iterable<PixelValue> pixelValues) {
      PixelValue out = new PixelValue();
      for (PixelValue val : pixelValues) {
        out.setCount(val.getCount() + out.getCount());
        out.setValue(val.getValue() + out.getValue());
      }
      return out;
    }
  }
}
