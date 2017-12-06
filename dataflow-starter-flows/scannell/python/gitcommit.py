#!/usr/bin/env python

import argparse
import logging

import apache_beam as beam
from apache_beam.transforms.combiners import Count
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import SetupOptions
from apache_beam.options.pipeline_options import GoogleCloudOptions
from apache_beam.options.pipeline_options import StandardOptions

from avro import schema

def getVersion():
  try:
    with open('version.txt') as ver:
      return ver.readline().strip()
  except IOError:
    return 'Unknown'

# schema = avro.schema.parse(open("user.avsc", "rb").read())
GIT_COMMIT_SCHEMA = schema.parse("""
{
  "type" : "record",
  "name" : "GitCommitTop",
  "namespace": "com.google.cloud.pso.data",
  "fields" : [ {
    "name" : "email",
    "type" : [ "string" ]
  }, {
    "name" : "count",
    "type" : [ "long" ]
  } ]
}
""")

class MyArgs(StandardOptions, GoogleCloudOptions):
  """Define commandline options for Python Dataflow"""
  @classmethod
  def _add_argparse_args(cls, parser):
    inargs = parser.add_mutually_exclusive_group(required=True)
    inargs.add_argument('--query',
                        dest='input_query',
                        help='Input GIT commit records to process.')
    inargs.add_argument('--input',
                        dest='input',
                        help='Input GIT commit records to process.')
    parser.add_argument('--output',
                        dest='output',
                        required=True,
                        help='Output GIT summary records to write results to.')

logger = logging.getLogger('git')

def run(argv=None):
  """Main entry point; defines and runs the wordcount pipeline."""

  logging.info("Running with version - %s" % (getVersion()))

  opts = MyArgs()
  p = beam.Pipeline(options=opts)

  # Read data in
  if opts.input is not None:
    lines = (p | 'read' >> beam.io.avroio.ReadFromAvro(file_pattern=opts.input)
               | 'fromAvro' >> beam.Map(lambda x: (x.get('author').get('email'),1)))
  else:
    lines = (p | 'read' >> beam.io.Read(beam.io.BigQuerySource(query=opts.input_query, use_standard_sql=True))
               | 'fromBQ' >> beam.Map(lambda x: (x['email'],1)))

  # Process it (Avro in and Avro out)
  counts = (lines
              | 'group' >> beam.transforms.combiners.Count.PerKey()
              | 'toAvro' >> beam.Map(lambda x: {"email":x[0], "count":x[1]}))

  # Write it out to Avro
  output = counts | beam.io.avroio.WriteToAvro(file_path_prefix=opts.output, schema=GIT_COMMIT_SCHEMA)

  result = p.run()

if __name__ == '__main__':
  logging.getLogger().setLevel(logging.INFO)
  run()

