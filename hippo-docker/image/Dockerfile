#docker build -f Dockerfile -t vinay345/hippo:pgsql-9.6 .
FROM openweb/oracle-tomcat:8-jre8
MAINTAINER swapnils <swapnils@e-pragati.in>
#ARG FILES=./image
ARG FILES=./image
ENV ENCODING=UTF-8 \
    CATALINA_HOME=/usr/local/tomcat \
\
    MAX_HEAP=512 \
    MIN_HEAP=256 \
    EXTRA_OPTS="" \
\
    RMI_SERVER_HOSTNAME=127.0.0.1 \
\
    MAIL_SESSION_RESOURCE_NAME=mail/Session \
    MAIL_USERNAME="" \
    MAIL_PASSWORD="" \
    MAIL_HOST=localhost \
    MAIL_DEBUG=false \
    MAIL_PROTOCOL=smtp \
    MAIL_AUTH=true \
    MAIL_PORT=25 \
    MAIL_FROM="" \
    MAIL_TLS_ENABLE=true \
\
    DB_RESOURCE_NAME=jdbc/repositoryDS \
    DB_HOST="172.16.76.38" \
    DB_PORT=5432 \
    DB_NAME=hippocms \
    DB_USER=hippoadmin \
    DB_PASS="snWuMfj" \
\
    REPO_BOOTSTRAP=true \
    CONSISTENCY_CHECK=none

WORKDIR $CATALINA_HOME

COPY ["bin/setenv.sh", \
        "bin/wait-for-it.sh", \
        "bin/entrypoint.sh", \
    "$CATALINA_HOME/bin/"]

COPY ["conf/repository.xml", \
        "conf/repository-consistency.xml", \
        "conf/repository-force.xml", \
        "conf/context.xml.template", \
        "conf/server.xml", \
        "conf/catalina.properties", \
        "conf/catalina.policy", \
        "conf/log4j.xml", \
    "$CATALINA_HOME/conf/"]

#RUN  rm -rf $CATALINA_HOME/webapps/* &&\
RUN  mkdir -p $CATALINA_HOME/endorsed \
COPY postgresql-42.1.4.jar $CATALINA_HOME/endorsed/
RUN chmod +x $CATALINA_HOME/bin/setenv.sh
RUN chmod +x bin/wait-for-it.sh
RUN chmod +x bin/entrypoint.sh

EXPOSE 1099

VOLUME ["/usr/local/repository/", "/usr/local/tomcat/logs"]
ENTRYPOINT ["bin/entrypoint.sh"]
CMD ["/bin/bash", "catalina.sh", "run"]

