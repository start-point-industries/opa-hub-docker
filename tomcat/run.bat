@echo off
echo Running containers
docker run --name opa-mysql-slim -e MYSQL_ROOT_PASSWORD=Passw0rd -d --health-cmd="mysqladmin ping --silent" opa-mysql-slim:1.0
docker run --name opa-tomcat-slim -p 8787:8080 --link opa-mysql-slim:opa-mysql-slim -d opa-tomcat-slim:1.0
REM docker exec -i -t opa-tomcat-slim /bin/bash