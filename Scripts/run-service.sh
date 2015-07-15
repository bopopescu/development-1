#!/bin/bash
#
# Requires the security service to be running
#
SERVICE=$1
LOGFILE=$SERVICE.log
SERVICE_DIR=/Users/Sterner/gitrepos/$SERVICE

COMMAND="java -jar $SERVICE_DIR/target/$SERVICE-1.0-SNAPSHOT.jar server $SERVICE_DIR/src/main/resources/default-configuration.yml >~/Logs/$LOGFILE 2>&1 &"

echo "Service Directory: $SERVICE_DIR"
echo "Service: $SERVICE"
echo "Logfile: $LOGFILE"
echo "Command: $COMMAND"

echo Starting service....
java -jar $SERVICE_DIR/target/$SERVICE-1.0-SNAPSHOT.jar server $SERVICE_DIR/src/main/resources/default-configuration.yml >~/Logs/$LOGFILE 2>&1 &
