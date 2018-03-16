#!/bin/bash
function waitForContainer {
	local container=$1
	
	until [ "`docker inspect -f {{.State.Running}} $container`" == "true" ]; do
		echo Waiting for $container to start
		sleep 3
	done;
	echo $container is running
	
	until [ "`docker inspect -f {{.State.Health.Status}} $container`" == "healthy" ]; do
		echo Waiting for $container to register as healthy
		sleep 3
	done;
	echo $container is healthy
}

echo Starting MySQL container
if ! docker run --name opa-mysql -e MYSQL_ROOT_PASSWORD=Passw0rd --health-cmd="mysqladmin ping --silent" -d mysql:5.7.21; then
	exit 1
fi

echo Starting Weblogic container
if ! docker run --name opa-weblogic -e ADMIN_PASSWORD=Passw0rd -p 7001:7001 --link opa-mysql:opa-mysql --health-cmd="curl -f http://localhost:7001/console || exit 1" -d container-registry.oracle.com/middleware/weblogic:12.2.1.3; then
	exit 1
fi

waitForContainer opa-mysql
waitForContainer opa-weblogic
echo All containers running

echo Installing OPA
if ! ( docker cp opa opa-weblogic:/u01/oracle/opa \
	&& docker exec --user root opa-weblogic chown oracle:oracle -R /u01/oracle/opa \
	&& docker exec --user root opa-weblogic chmod +x -R /u01/oracle/opa/bin/install.sh \
	&& docker exec opa-weblogic /u01/oracle/opa/bin/install.sh install -non-secure-cookie=true -name=dev -dbconn=opa-mysql:3306 -dbuser=root -dbpass=Passw0rd -hubpass=Passw0rd -key=12345678 -wladmin=AdminServer -wladminurl=t3://localhost:7001 -target=AdminServer -wldomain=/u01/oracle/user_projects/domains/base_domain -wlstdir=/u01/oracle/wlserver/common/bin ); then
	exit 1
fi

echo Your hub is now ready at http://localhost:7001/dev/opa-hub
echo Username: admin
echo The generated admin password can be found about 10 lines above.

# docker exec -i -t opa-weblogic /bin/bash