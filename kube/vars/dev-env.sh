#!/usr/bin/env bash
# Variables: 
ENV="core-dev"
datestring="$(date)"
BOOTSTRAP_NONPROD="kafka.stg.comms.food-commercial.sainsburys.co.uk:9092"
VLDT_VALUE=confluent.value.schema.validation=true
VLDT_KEY=confluent.key.schema.validation=true
DEV_PROPERTIES="command-dev.propertie" # properie is not a typo, this is how it's named on the core-dev pod


# Commands:
KAFKA_POD="$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep kafka-cli)"
CURR_CTXT="$(kubectl config current-context)"
USE_CTXT="$(kubectl config use-context $CONTEXT)"

DESCRIBE="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --describe"
CRE_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --topic $TOPIC --create --replication-factor 3 --partitions $PARTITIONS --config cleanup.policy=$CLEANUP_POLICY --config retention.ms=$RETENTION "
VALIDATE="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --alter --topic $TOPIC  --add-config $VLDT_VALUE --add-config $VLDT_KEY"
REM_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --topic $TOPIC --delete
