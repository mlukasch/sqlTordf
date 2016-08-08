#!/usr/bin/env bash
java -jar h2*.jar -web -webAllowOthers -webPort 8082 -tcp -tcpAllowOthers -tcpPort 9092 && \
java -cp h2*.jar org.h2.tools.RunScript -user "sa" -password "" -url "jdbc:h2:file:/test" -script /dump.sql


