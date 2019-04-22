FROM docker/compose:1.24.0
LABEL description="Docker image based on Compose with AWS CLI and SBT."

ENV AWS_VERSION   1.16.144
ENV SBT_VERSION   1.2.8
ENV JAVA_HOME     /usr/lib/jvm/java-1.8-openjdk
ENV PATH          $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN apk add --no-cache openjdk8 python2 bash

RUN wget -O - https://sbt-downloads.cdnedge.bluemix.net/releases/v$SBT_VERSION/sbt-$SBT_VERSION.tgz \
  | gunzip \
  | tar -x -C /usr/local && \
  ln -s /usr/local/sbt/bin/sbt /usr/bin/sbt && \
  chmod 0755 /usr/bin/sbt && \
  apk add --no-cache py-pip && \
  pip install --no-cache-dir awscli==$AWS_VERSION && \
  apk del py-pip
  