FROM centos:latest

ARG FLUME_VERSION=1.9.0

RUN yum update -y && \
  yum install -y java-1.8.0-openjdk && yum clean all && rm -rf /var/cache/yum && \
  curl -L http://archive.apache.org/dist/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz | tar xz && \
  mv apache-flume-${FLUME_VERSION}-bin apache-flume && \
  cp /apache-flume/conf/flume-conf.properties.template /apache-flume/conf/flume-conf.properties

ENV JAVA_HOME=/usr
ENV AGENT=agent

WORKDIR /apache-flume

RUN mkdir -p external

COPY ./*.jar ./lib/

CMD [ "sh","-c", "./bin/flume-ng agent -n ${AGENT} -c conf -f conf/flume-conf.properties" ]
