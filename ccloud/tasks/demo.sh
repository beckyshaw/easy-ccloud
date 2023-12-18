source vars/dev-env.sh

# Schema Validation Script
echo ----------------------------------------------------------------------------------
echo "Running Schema Validation script..."
echo 
echo Date-Time: $datestring
echo ----------------------------------------------------------------------------------
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
echo Environment selected: $ENVIRONMENT
echo ----------------------------------------------------------------------------------

#REDACTED
    # if  [[ $ENVIRONMENT =~ $ENV_DEV ]]; then
        #     echo "Environment is $ENVIRONMENT" 
        #     read -p "Continue (yes/no)?" CONT
        #     if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
        #         echo "Showing Topic $TOPIC, Ctrl-C to cancel";
        #         sleep 5
        #         echo "Using $TOPIC"
        #     else 
        #         echo "Exiting....";
        #     fi

        # else
        #     echo "Invalid environment selected"
        # fi

if  [[ $ENVIRONMENT =~ $ENV ]]; then
    echo "Environment is $ENVIRONMENT" 
    read -p "Continue (yes/no)?" CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
        echo "Showing Topic "$TOPIC", Ctrl-C to cancel";
        sleep 5
        #echo "Confirmed topic is $TOPIC"
        echo $CMD_LS
    else 
        echo "Exiting....";
    fi

else
    echo "Invalid environment selected, Expected: $ENV"
fi