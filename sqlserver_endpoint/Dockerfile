FROM maven:3-jdk-8 as compiler

ARG REPO=https://github.com/linl33/experimental-sync-endpoint
ARG REPO_BRANCH=container-config

RUN git clone -b ${REPO_BRANCH} --single-branch --depth=1 ${REPO} sync

# builds the mysql variant but the war works for all 3 databases  
RUN cd /sync/src/main/libs && \
    . /sync/src/main/libs/mvn_local_installs && \
    sed -i "s/odk-mysql-it-settings/odk-container-settings/" /sync/aggregate-mysql/pom.xml && \
    cd /sync && \
    mvn -pl "aggregate-src, odk-container-settings, aggregate-mysql" package && \
    unzip /sync/aggregate-mysql/target/aggregate-mysql-*.war -d /ROOT


FROM tomcat:8.5

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]

COPY init.sh /tmp/init.sh
COPY server.xml conf/
COPY --from=compiler /ROOT webapps/ROOT/

EXPOSE 8443
ENTRYPOINT ["/tmp/init.sh"]
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
