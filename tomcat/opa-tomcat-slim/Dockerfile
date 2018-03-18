FROM openjdk:8-jre-alpine
COPY files /files
RUN chmod +x /files/install.sh
RUN . /files/install.sh

FROM tomcat:7-jre7-alpine
COPY --from=0 /files/opa/bin/lib/mysql-connector-java-5.1.44-bin.jar /usr/local/tomcat/lib/
COPY --from=0 /tmp/determinations-server /usr/local/tomcat/webapps/determinations-server
COPY --from=0 /tmp/web-determinations /usr/local/tomcat/webapps/web-determinations
COPY --from=0 /tmp/opa-hub /usr/local/tomcat/webapps/opa-hub
