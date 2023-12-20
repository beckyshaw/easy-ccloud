# #!/bin/bash
# Variable file
source vars/prod-env.sh

# Current-context verification
if [[ $CURR_CTXT =~ $ENV ]]; then
echo "Environment is $ENV"
echo " Current context is $CURR_CTXT"
echo -------------------------------
echo "Date: $datestring"
echo "Environment and context match"
echo -------------------------------

else
    echo ---------------------------------------------------------------
    echo "Context/Env mismatch! Context: $CURR_CTXT, ENV: $ENV"
    echo ---------------------------------------------------------------
    echo " Select kube context : "
    PS3="Select context: "
    select NEW_CTXT in core-dev confluent-nonprod confluent-prod
    do
        echo "Selected context: $CONTEXT"   
        sleep 3
        echo "$(kubectl config use-context $NEW_CTXT)" 
        break;
    done
echo -------------------------------
echo " New context is: $NEW_CTXT"   
echo -------------------------------
fi

# Script Start >
set -e
echo -------------------------------
echo " TOPIC CREATION SCRIPT : $ENV"   
echo -------------------------------
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

# Commands
    DESCRIBE="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --describe"
    CREATE_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --create --replication-factor 3 --partitions $PARTITIONS --config cleanup.policy=$CLEANUP_POLICY --config retention.ms=$RETENTION"
    VALIDATE="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --alter --topic $TOPIC  --add-config $VLDT_VALUE --add-config $VLDT_KEY"
    REM_TOPIC="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --topic $TOPIC --delete"
    EXISTS="kafka-topics --bootstrap-server $BOOTSTRAP_PROD --command-config $FILE_PROPERTIES --describe | grep $TOPIC"


# Action
if  [[ $ENVIRONMENT =~ $ENV ]]; then
    echo "Environment is $ENVIRONMENT"
    echo " Command/s to be executed, using $FILE_PROPERTIES are.... "
    echo "kubectl exec --stdin --tty $KAFKA_POD -- $REM_TOPIC"
    echo 
    read -p "Continue (yes/no)? " CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "$CONT" = "Y" ] || [ "CONT" = "Yes" ]; then
        eval "kubectl exec --stdin --tty $KAFKA_POD -- $REM_TOPIC";
        echo "Complete"
        echo "Delete topic verification"
        eval "kubectl exec --stdin --tty $KAFKA_POD -- $EXISTS"
        sleep 5
        echo "Closing.... "
    else 
        echo "Exiting....";
    fi

else
    echo "Invalid environment selected, Expected: $ENV"
fi
