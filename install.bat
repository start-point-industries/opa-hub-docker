@echo off
echo Starting MySQL container
docker run --name opa-mysql -e MYSQL_ROOT_PASSWORD=Passw0rd --health-cmd="mysqladmin ping --silent" -d mysql:5.7.21 
if errorlevel 1 (
  EXIT /B 1
)

echo Starting Weblogic container
docker run --name opa-weblogic -e ADMIN_PASSWORD=Passw0rd -p 7001:7001 --link opa-mysql:opa-mysql --health-cmd="curl -f http://localhost:7001/console || exit 1" -d container-registry.oracle.com/middleware/weblogic:12.2.1.3
if errorlevel 1 (
  EXIT /B 1
)

call :waitForContainer opa-mysql
call :waitForContainer opa-weblogic
echo All containers running

echo Installing OPA
docker cp opa opa-weblogic:/u01/oracle/opa
docker exec --user root opa-weblogic chown oracle:oracle -R /u01/oracle/opa
docker exec opa-weblogic /u01/oracle/opa/bin/install.sh install -non-secure-cookie=true -name=dev -dbconn=opa-mysql:3306 -dbuser=root -dbpass=Passw0rd -hubpass=Passw0rd -key=12345678 -wladmin=AdminServer -wladminurl=t3://localhost:7001 -target=AdminServer -wldomain=/u01/oracle/user_projects/domains/base_domain -wlstdir=/u01/oracle/wlserver/common/bin
if errorlevel 1 (
  EXIT /B 1
)

echo Your hub is now ready at http://localhost:7001/dev/opa-hub
echo Username: admin
echo The generated admin password can be found about 10 lines above.

EXIT /B 0

:waitForContainer
for /f %%a in ('docker inspect --format="{{.State.Running}}" %*') do set "isRunning=%%a"
if NOT "%isRunning%" == "true" (
  echo Waiting for %* to start
  timeout /t 3 /nobreak
  goto waitForContainer
)
echo %* is running

:healthyLoop
for /f %%a in ('docker inspect --format="{{.State.Health.Status}}" %*') do set "health=%%a"
if NOT "%health%" == "healthy" (
  echo Waiting for %* to register as healthy
  timeout /t 3 /nobreak
  goto healthyLoop
)
echo %* is healthy

echo END OF FUNCTION
EXIT /B 0

REM docker exec -i -t opa-weblogic /bin/bash