FROM openjdk:8-jre-slim
ARG VERID=1
COPY /target/dataflow-demo-${VERID}.jar /target/dataflow-demo.jar
ENTRYPOINT ["/usr/bin/java","-jar","/target/dataflow-demo.jar"]
