# #!/bin/bash
# Variable file
source vars/stg-env.sh

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



# Schema Validation Script Start >
# set -e
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
echo "Confirming $TOPIC exists on pod....."
eval "kubectl exec --stdin --tty $KAFKA_POD -- $EXISTS"
sleep 5
echo ----------------------------------------------------------------------------------

# Commands:
    DESCRIBE="kafka-topics --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --topic $TOPIC --describe"
    VALIDATE1="kafka-configs --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --alter --topic $TOPIC --add-config $VLDT_VALUE"
    VALIDATE2="kafka-configs --bootstrap-server $BOOTSTRAP_NONPROD --command-config $FILE_PROPERTIES --alter --topic $TOPIC --add-config $VLDT_KEY"

# Action

if  [[ $ENVIRONMENT =~ $ENV ]]; then
    echo "Environment is $ENVIRONMENT"
    echo " Command/s to be executed, using $FILE_PROPERTIES are.... "
    echo "[Command]:  $VALIDATE1"
    echo "[Command]:  $VALIDATE2"
    echo 

    read -p "Continue (yes/no)? " CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "$CONT" = "Y" ] || [ "CONT" = "Yes" ]; then
        eval "kubectl exec --stdin --tty $KAFKA_POD -- $VALIDATE1"
        eval "kubectl exec --stdin --tty $KAFKA_POD -- $VALIDATE2";
        echo "Complete"
        echo "New topic config"
        eval "kubectl exec --stdin --tty $KAFKA_POD -- $EXISTS"
        sleep 5
        echo "Closing.... "
    else 
        echo "Exiting....";
    fi

else
    echo "Invalid environment selected, Expected: $ENV"
fi
