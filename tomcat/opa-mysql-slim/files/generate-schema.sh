#!/bin/bash
unzip /files/opa.zip -d /files

cd /files/opa/bin
. ./setEnv.sh

# Intaller saves sql to /files/opa/bin/output/opahub_create_schema.sql
java -cp "$INSTALL_CP" com.oracle.determinations.hub.exec.HubExecCmdLineCustomer install_database -name=dev -dbconn=na -dbuser=na -dbpass=na -createdb -createuser -sqlonfail -out=output -doresetpassword -resetpass=Passw0rd

# Remove erroneous BOM
sed -i $'s/\xEF\xBB\xBF//' /files/opa/bin/output/opahub_create_schema.sql

# Use database
sed -i '1i use OPA_HUB;' /files/opa/bin/output/opahub_create_schema.sql

exit 0
