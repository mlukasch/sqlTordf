FROM java:openjdk-8-alpine

RUN apk --update add wget tar

# Install D2RQ:
ENV D2RQ_VERSION=0.8.1
RUN wget https://github.com/downloads/d2rq/d2rq/d2rq-$D2RQ_VERSION.tar.gz && \
    tar -xvf d2rq-$D2RQ_VERSION.tar.gz

# Install H2 jdbc driver:
RUN wget http://www.h2database.com/automated/h2-latest.jar && \
    cp h2-latest.jar /d2rq-$D2RQ_VERSION/lib/.

