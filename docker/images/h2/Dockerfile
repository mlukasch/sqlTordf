FROM java:openjdk-8-alpine

RUN apk --update add wget tar supervisor

# Install H2 DB:
ENV H2_VERSION 1.4.192
RUN wget http://repo2.maven.org/maven2/com/h2database/h2/$H2_VERSION/h2-$H2_VERSION.jar

# TCP Port:
EXPOSE 9092

# Admin Page Port:
EXPOSE 8082

# Data dir:
ENV H2_DATA_DIR /data
RUN mkdir -p $H2_DATA_DIR && chmod a+rwx /data

# COPY DATA:
#COPY ./datafiles /datafiles
#COPY ./dump.sql /dump.sql
#COPY ./dump2.sql /dump2.sql
COPY ./dump.sql /dump.sql


# Start H2 DB:
COPY ./supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
#COPY ./startDB.sh /startDB.sh
#CMD ["/bin/sh", "/startDB.sh"]
#CMD ["java -jar h2*.jar -web -webAllowOthers -webPort 8082 -tcp -tcpAllowOthers -tcpPort 9092 -baseDir ${H2_DATA_DIR}"]

