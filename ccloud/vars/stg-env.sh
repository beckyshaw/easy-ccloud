#!/usr/bin/env bash
# Variables: 
ENV="{NONPROD_AWS_ACCOUNT_NAME}" # this is your nonprod aws account for SSO e.g. confluent-nonprod
datestring="$(date)"
BOOTSTRAP_NONPROD="{bootstrap-server:port}"
VLDT_VALUE=confluent.value.schema.validation=true
VLDT_KEY=confluent.key.schema.validation=true
FILE_PROPERTIES="{properties-filename}"


# Commands:
KAFKA_POD="$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep kafka-cli)"
CURR_CTXT="$(kubectl config current-context)"
USE_CTXT="$(kubectl config use-context $CONTEXT)"

DESCRIBE="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --describe"
CREATE_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --topic $TOPIC --create --replication-factor 3 --partitions $PARTITIONS --config cleanup.policy=$CLEANUP_POLICY --config retention.ms=$RETENTION"
VALIDATE="kafka-configs --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --alter --topic $TOPIC  --add-config $VLDT_VALUE, $VLDT_KEY"
REM_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --topic $TOPIC --delete"
EXISTS="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --describe --topic $TOPIC"


AWSPENDING="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSPENDING"
AWSCURRENT="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSCURRENT"
AWSPREVIOUS="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSPREVIOUS" 

KEY_DIR="nonprod/env/"
DELETE_KEY="confluent api-key delete"