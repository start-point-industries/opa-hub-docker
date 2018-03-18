CONTEXT=/files/context.xml
TEMPLATES=/files/opa/templates

unzip /files/opa.zip -d /files
unzip $TEMPLATES/opa.ear -d /tmp

sed -i -- 's/opacloud-{0}-{1}.log/\/tmp\/ods.log/g' /tmp/determinations-server/WEB-INF/classes/log4j.xml
sed -i -- 's/opacloud-{0}-{1}.log/\/tmp\/owd.log/g' /tmp/web-determinations/WEB-INF/classes/log4j.xml
sed -i -- 's/opacloud-{0}-{1}.log/\/tmp\/hub.log/g' /tmp/opa-hub/WEB-INF/classes/log4j.xml

cp -R /tmp/lib /tmp/determinations-server/WEB-INF
cp -R /tmp/lib /tmp/web-determinations/WEB-INF
cp -R /tmp/lib /tmp/opa-hub/WEB-INF

cp $CONTEXT /tmp/determinations-server/META-INF
cp $CONTEXT /tmp/web-determinations/META-INF
cp $CONTEXT /tmp/opa-hub/META-INF