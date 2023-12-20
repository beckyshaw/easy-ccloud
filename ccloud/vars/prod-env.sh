#!/usr/bin/env bash
# Variables: 
ENV="{aws-profile-prod-name}" 
datestring="$(date)"
BOOTSTRAP_PROD="{bootstrap-server:port}" 
VLDT_VALUE=confluent.value.schema.validation=true
VLDT_KEY=confluent.key.schema.validation=true
FILE_PROPERTIES="properties-filename" 

# Commands:
KAFKA_POD="$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep kafka-cli)"
CURR_CTXT="$(kubectl config current-context)"
USE_CTXT="$(kubectl config use-context $CONTEXT)"

DESCRIBE="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --describe"
CREATE_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --create --replication-factor 3 --partitions $PARTITIONS --config cleanup.policy=$CLEANUP_POLICY --config retention.ms=$RETENTION "
VALIDATE="kafka-configs --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --alter --topic $TOPIC  --add-config $VLDT_VALUE, $VLDT_KEY"
REM_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --delete"
EXISTS="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --describe"


AWSPENDING="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSPENDING"
AWSCURRENT="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSCURRENT"
AWSPREVIOUS="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSPREVIOUS" 

KEY_DIR="prod/env/"
# API_KEY="prod/env/test-key"
DELETE_KEY="confluent api-key delete"


# FUNCTIONS
function func_progress() {
for((i=0;i<=100;i+=3)); do
    printf "%-*s" $((i+1)) '[' | tr ' ' '#'
    printf "%*s%3d%%\r"  $((101-i))  "]" "$i"
    sleep 0.3
done; echo
}
