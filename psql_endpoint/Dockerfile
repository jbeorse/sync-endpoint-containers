FROM tomcat:8.5.12

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
COPY ODKAggregate.war /tmp/ODKAggregate.war
COPY init.sh /tmp/init.sh
COPY postgresql-9.4.1212.jar /usr/local/tomcat/lib

RUN apt-get update
RUN apt-get install -y zip

CMD ["/tmp/init.sh", ""]
