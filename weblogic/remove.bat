@echo off
echo Removing containers
docker rm -f opa-weblogic-full
docker rm -f opa-mysql-full