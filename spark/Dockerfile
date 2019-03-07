FROM ubuntu:latest

RUN apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository ppa:git-core/ppa \
 && apt-get update \
 && apt-get install -y curl unzip git \
    python-pip python-dev python3.6 \
 && pip install py4j \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# JAVA
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=131
ARG JAVA_BUILD_NUMBER=11
ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/d54c1d3a095b4ff2b6607d096fa80163/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# SCALA
ARG SCALA_MAJOR_VERSION=2
ARG SCALA_MINOR_VERSION=11
ARG SCALA_REVISION=11
ENV SCALA_HOME /usr/scala-${SCALA_MAJOR_VERSION}.${SCALA_MINOR_VERSION}.${SCALA_REVISION}

ENV PATH $PATH:$SCALA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  "http://downloads.lightbend.com/scala/${SCALA_MAJOR_VERSION}.${SCALA_MINOR_VERSION}.${SCALA_REVISION}/scala-${SCALA_MAJOR_VERSION}.${SCALA_MINOR_VERSION}.${SCALA_REVISION}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $SCALA_HOME /usr/scala

# SBT
ARG SBT_MAJOR_VERSION=0
ARG SBT_MINOR_VERSION=13
ARG SBT_REVISION=11
ENV SBT_HOME /usr/sbt-${SBT_MAJOR_VERSION}.${SBT_MINOR_VERSION}.${SBT_REVISION}
ENV PATH $PATH:$SBT_HOME/bin
RUN curl -sL --retry 3 --insecure \
  "https://dl.bintray.com/sbt/native-packages/sbt/${SBT_MAJOR_VERSION}.${SBT_MINOR_VERSION}.${SBT_REVISION}/sbt-${SBT_MAJOR_VERSION}.${SBT_MINOR_VERSION}.${SBT_REVISION}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
  && mv /usr/sbt /usr/sbt-${SBT_MAJOR_VERSION}.${SBT_MINOR_VERSION}.${SBT_REVISION} \
  && ln -s $SBT_HOME /usr/sbt

# HADOOP
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/ \
 && rm -rf $HADOOP_HOME/share/doc \
 && chown -R root:root $HADOOP_HOME

# SPARK
ENV SPARK_VERSION 2.1.1
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "http://d3kbcqa49mib13.cloudfront.net/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME

WORKDIR $SPARK_HOME
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
