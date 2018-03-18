FROM openjdk:8-jre-alpine
COPY files /files
RUN chmod +x /files/generate-schema.sh 
RUN . /files/generate-schema.sh

FROM mysql:5.7.21
COPY files/01-create_db.sql /docker-entrypoint-initdb.d/
COPY --from=0 files/opa/bin/output/opahub_create_schema.sql /docker-entrypoint-initdb.d/02-opahub_create_tables_mysql.sql
COPY files/03-create_admin.sql /docker-entrypoint-initdb.d/