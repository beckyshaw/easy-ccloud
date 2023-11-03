# #!/bin/bash
source vars/dev-env.sh

# Schema Validation Script
echo "Running Schema Validation script..."
PS3="Please select the environment: "

select ENVIRONMENT in core-dev confluent-nonprod confluent-prod
do
    echo "Selected environment: $ENVIRONMENT"
    break;
done

read -p "Enter a topic: " TOPIC
echo "You entered $TOPIC"
echo
echo
echo Schema Validation:
echo ----------------------------------------------------------------------------------
echo Date-Time: $datestring
echo Topic: $TOPIC
echo Environment $ENVIRONMENT
echo ----------------------------------------------------------------------------------

# if  [[ $ENVIRONMENT =~ $ENV ]]; then
#     echo "Environment is $ENVIRONMENT"
#     read -p "Continue (yes/no)?" CONT
#     if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
#         echo "Showing Topic $TOPIC, Ctrl-C to cancel";
#         sleep 5
#         echo "Using $TOPIC"; echo $COMMAND_LS
#     else
#         echo "Exiting....";
#     fi

# else
#     echo "Invalid environment selected, Expected: $ENV"
# fi


echo " Script will run  .... "
echo "kubectl exec --stdin --tty $KAFKA_POD -- $CREATE_TOPIC"
    read -p "Continue (yes/no)?" CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
        eval "kubectl exec --stdin --tty $KAFKA_POD -- $CREATE_TOPIC";
        sleep 5
        echo "Script success.... Closing"
    else 
        echo "Exiting....";
    fi

