FROM python:2-slim

# Added by ricc@ as a test
MAINTAINER Mark S <scannell@google.com>

# TODO(ricc): change this to `cat ./VERSION` into VERID :)
ARG VERID=2

RUN pip install google-cloud-dataflow
RUN echo ${VERID} > /version.txt

COPY gitcommit.py /target/gitcommit.py

ENTRYPOINT ["/usr/local/bin/python","/target/gitcommit.py"]
