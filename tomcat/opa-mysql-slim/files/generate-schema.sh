#!/bin/bash
unzip /files/opa.zip -d /files

cd /files/opa/bin
. ./setEnv.sh

java -cp "$INSTALL_CP" com.oracle.determinations.hub.exec.HubExecCmdLineCustomer install_database -name=dev -dbconn=na -dbuser=na -dbpass=na -createdb -createuser -sqlonfail -out=output -resetpass=Passw0rd -doresetpassword
exit 0
# sql script outputs to /files/opa/bin/output/opahub_create_schema.sql