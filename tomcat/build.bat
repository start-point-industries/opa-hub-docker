@echo off
echo Building containers
docker build -t opa-mysql-slim:1.0 opa-mysql-slim
docker build -t opa-tomcat-slim:1.0 opa-tomcat-slim