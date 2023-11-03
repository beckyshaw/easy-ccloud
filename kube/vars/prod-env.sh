#!/usr/bin/env bash
# Variables: 
ENV="confluent-prod"
datestring="$(date)"
BOOTSTRAP_PROD="lkc-xj9yz-e05y2.eu-west-1.aws.glb.confluent.cloud:9092"
VLDT_VALUE=confluent.value.schema.validation=true
VLDT_KEY=confluent.key.schema.validation=true
FILE_PROPERTIES="prodconfig.properties"

# Commands:
KAFKA_POD="$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep kafka-cli)"
CURR_CTXT="$(kubectl config current-context)"
USE_CTXT="$(kubectl config use-context $CONTEXT)"

DESCRIBE="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --describe"
CREATE_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --create --replication-factor 3 --partitions $PARTITIONS --config cleanup.policy=$CLEANUP_POLICY --config retention.ms=$RETENTION "
VALIDATE="kafka-configs --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --alter --topic $TOPIC  --add-config $VLDT_VALUE, $VLDT_KEY"
REM_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --delete"
EXISTS="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --describe"


