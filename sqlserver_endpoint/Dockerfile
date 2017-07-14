FROM maven:3-jdk-8 as compiler

ARG REPO=https://github.com/jbeorse/experimental-sync-endpoint
ARG REPO_BRANCH=sync-endpoint
ARG AGG_VAR=sqlserver

RUN git clone -b ${REPO_BRANCH} ${REPO} sync

# TODO: Replace sed with odk-${AGG_VAR}-container-settings 

RUN cd /sync/src/main/libs && \
    . /sync/src/main/libs/mvn_local_installs && \
    sed -i "s/odk-${AGG_VAR}-it-settings/odk-${AGG_VAR}-settings/" /sync/aggregate-${AGG_VAR}/pom.xml && \
    cd /sync && \
    mvn -pl "aggregate-src, odk-${AGG_VAR}-settings, aggregate-${AGG_VAR}" package && \
    mv /sync/aggregate-${AGG_VAR}/target/aggregate-${AGG_VAR}-*.war /sync/ODKAggregate.war


FROM tomcat:8.5

RUN apt-get update && \
    apt-get install -y zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]

COPY init.sh /tmp/init.sh
COPY server.xml conf/

# TODO: move key import to init.sh, so that changing ca cert doesn't require image rebuild
COPY mezuricloud-perhaps-same.cer /tmp/mezuricloud-perhaps-same.cer
RUN keytool -noprompt -import -trustcacerts -alias mezuricloud -keystore "/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts" -file /tmp/mezuricloud-perhaps-same.cer -storepass changeit

COPY --from=compiler /sync/ODKAggregate.war /tmp/ODKAggregate.war

EXPOSE 8443
CMD ["/tmp/init.sh", ""]
