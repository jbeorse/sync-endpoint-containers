FROM tomcat:8.5

RUN ["rm", "-rf", "/usr/local/tomcat/webapps/ROOT"]
COPY ODKAggregate.war /tmp/ODKAggregate.war
COPY init.sh /tmp/init.sh
COPY ldap_cert.cer /tmp/ldap_cert.cer
COPY https_cert.crt /tmp/https_cert.crt
COPY server.xml /tmp/server.xml
COPY tomcat.keystore /tmp/tomcat.keystore
COPY tomcat_https.keystore /tmp/tomcat_https.keystore

RUN apt-get update
RUN apt-get -fy --force-yes upgrade
RUN apt-get install -y zip

RUN keytool -noprompt -import -trustcacerts -alias mezuricloud2 -keystore "/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts" -file /tmp/ldap_cert.cer -storepass changeit
RUN keytool -noprompt -import -trustcacerts -alias mezuriserver -keystore "/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts" -file /tmp/https_cert.crt -storepass changeit

#EXPOSE 80
#EXPOSE 443
CMD ["/tmp/init.sh", ""]
