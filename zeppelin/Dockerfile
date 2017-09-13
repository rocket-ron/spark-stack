FROM spark:latest

# PYTHON MODULES
RUN apt-get update \
  && apt-get install -y build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev libpng-dev libfreetype6-dev gfortran python-dev \
  && pip install numpy pandas scikit-learn matplotlib

# ZEPPELIN
ENV ZEPPELIN_RELEASE_VERSION=0
ENV ZEPPELIN_MAJOR_VERSION=7
ENV ZEPPELIN_MINOR_VERSION=2
ENV ZEPPELIN_HOME=/usr/zeppelin-${ZEPPELIN_RELEASE_VERSION}.${ZEPPELIN_MAJOR_VERSION}.${ZEPPELIN_MINOR_VERSION}
ENV PATH $PATH:$ZEPPELIN_HOME/bin
RUN curl -sL --retry 3 \
  "http://www-us.apache.org/dist/zeppelin/zeppelin-0.7.2/zeppelin-0.7.2-bin-all.tgz" \
  | gunzip \
  | tar -x -C /usr/ \
  && mv /usr/zeppelin-${ZEPPELIN_RELEASE_VERSION}.${ZEPPELIN_MAJOR_VERSION}.${ZEPPELIN_MINOR_VERSION}-bin-all /usr/zeppelin-${ZEPPELIN_RELEASE_VERSION}.${ZEPPELIN_MAJOR_VERSION}.${ZEPPELIN_MINOR_VERSION} \
  && ln -s $ZEPPELIN_HOME /usr/zeppelin

WORKDIR $ZEPPELIN_HOME
CMD ["bin/zeppelin.sh"]
