#!/bin/bash
# Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
​
# Generate response file from template
$SCRIPT_FILE/prep_bocrsp.py -s $SCRIPT_FILE/templates/boc.rsp.tmpl -d $SCRIPT_FILE/boc.rsp
​
​
$JAVA_HOME/bin/java -jar $SCRIPT_FILE/$BOC_OUI_JAR -invPtrLoc /u01/oraInst.loc DB_PORT=1522 -silent -responseFile $SCRIPT_FILE/boc.rsp -ignoreSysPrereqs -debug -logLevel finest
​
status=$?
​
if [ 0 -ne $status ] ; then
   exit 1
fi
​
# Remove files which are no longer required
rm $SCRIPT_FILE/$BOC_OUI_JAR $SCRIPT_FILE/boc.rsp
​
source $DOMAIN_HOME/bin/setDomainEnv.sh
savedPath=`pwd`
cd $DOMAIN_HOME
#Create Data Source
echo "Creating datasource"
wlst.sh $SCRIPT_FILE/createDataSource.py
​
if [ "false" == "$USE_OPSS" ] ; then
        echo "Users and Groups"
        wlst.sh $SCRIPT_FILE/users_groups.py
fi
cd $savedPath
​
#Update Infranet log leve
if [ ! -z "$INFRANET_LOG_LEVEL" ] ; then
        log_location=${DOMAIN_LOGS_DIR:-$APP_INSTALL_LOC}
        echo "infranet.log.level=$INFRANET_LOG_LEVEL" >> $DOMAIN_HOME/Infranet.properties
        echo "infranet.log.file=${log_location}/javapcm.log" >> $DOMAIN_HOME/Infranet.properties
fi
