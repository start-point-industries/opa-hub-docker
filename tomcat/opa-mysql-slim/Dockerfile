#FROM openjdk:8-jre-alpine
#COPY files /files
#RUN chmod +x /files/generate-schema.sh 
#RUN . /files/generate-schema.sh

FROM mysql:5.7.21
COPY files/01-createdb.sql /docker-entrypoint-initdb.d/
COPY files/02-opahub_create_tables_mysql.sql /docker-entrypoint-initdb.d/
COPY files/03-opahub_seed_data.sql /docker-entrypoint-initdb.d/
#COPY files/install-schema.sh /files/
#COPY files/opa-entrypoint.sh /
#COPY --from=0 /files/opa/bin/output/opahub_create_schema.sql /files/
#RUN chmod +x /files/install-schema.sh
#RUN chmod +x /opa-entrypoint.sh
#RUN echo -e ". /files/install-schema.sh > /files/install-schema.log\n$(cat entrypoint.sh)" > entrypoint.sh
#ENTRYPOINT ["/opa-entrypoint.sh"]