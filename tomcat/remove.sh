#!/bin/bash
echo Removing containers
docker rm -f opa-mysql-slim
docker rm -f opa-tomcat-slim