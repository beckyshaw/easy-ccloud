# Schema Validation Script Start >
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
    echo "Enter retention.ms value (7 days = 604800000)..... Google is your friend if you need to calculate ms into hours/days"
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