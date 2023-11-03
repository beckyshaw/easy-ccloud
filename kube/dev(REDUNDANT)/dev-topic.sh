# #!/bin/bash
source vars/dev-env.sh

# Current-context verification
CONTEXT_CHECK="$(kubectl config use-context $CONTEXT)"

if [[ $CONTEXT_CHECK =~ $ENV ]]; then
echo
echo "Environment and context match"
else
    echo " Select kube context : "
    PS3="Select context: "
    select CONTEXT in core-dev confluent-nonprod confluent-prod
    do
        echo "Selected environment: $ENVIRONMENT"
        break;
    done
    # CONTEXT_CHECK="$(kubectl config use-context $CONTEXT)"
fi

echo 
echo "Running Schema Validation script..."
PS3="Please select the environment: "
select ENVIRONMENT in core-dev confluent-nonprod confluent-prod
do
    echo "Selected environment: $ENVIRONMENT"
    break;
done

echo ----------------------------------------------------------------------------------
read -p "Enter a topic: " TOPIC
echo "You entered $TOPIC"
echo ----------------------------------------------------------------------------------
read -p "How many partitions are required for $TOPIC?  " PARTITIONS
echo "You need $PARTITIONS partitions"
case $PARTITIONS in
[0-9]) echo $PARTITIONS >> manual-entry ;;
*)
echo " Entered value is not number " ;;
esac
echo ----------------------------------------------------------------------------------
PS3="Select a cleanup policy.."
select CLEANUP_POLICY in compact delete
do
    echo "Selected cleanup policy: $CLEANUP_POLICY"
    break;
done
echo ----------------------------------------------------------------------------------
while true; do
    echo "Enter retention.ms value (7 days = 604800000)"
    read RETENTION
    if [ -z $RETENTION ]; then
        echo "Value cannot be empty"
        continue # loop
    fi
    break
done
echo ----------------------------------------------------------------------------------
echo "You have selected the following fields: "
echo ----------------------------------------------------------------------------------
echo "Topic name : $TOPIC"
echo "Number of partitions : $PARTITIONS"
echo "Cleanup policy required : $CLEANUP_POLICY"
echo "Retention period is : $RETENTION"
echo "Kafka pod selected : $KAFKA_POD"
echo ----------------------------------------------------------------------------------

KAFKA_CMD="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $NONPROD_PROPERTIES"
DESCRIBE=" --describe"
CREATE_TOPIC=" --topic $TOPIC --create --replication-factor 3 --partitions $PARTITIONS --config cleanup.policy=$CLEANUP_POLICY --config retention.ms=$RETENTION "

if  [[ $ENVIRONMENT =~ $ENV ]]; then
    echo "Environment is $ENVIRONMENT"
    echo " Command/s to be executed, using $DEV_PROPERTIES are.... "
    echo "kubectl exec --stdin --tty $KAFKA_POD -- $KAFKA_CMD $DESCRIBE"
    echo 
    read -p "Continue (yes/no)? " CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
        eval "kubectl exec --stdin --tty $KAFKA_POD -- $CREATE_TOPIC";
        echo "....."
        sleep 5
        echo "Closing.... "
    else 
        echo "Exiting....";
    fi

else
    echo "Invalid environment selected, Expected: $ENV"
fi
