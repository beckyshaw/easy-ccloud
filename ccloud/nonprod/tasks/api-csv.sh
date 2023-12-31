# #!/bin/bash
# Variable file
source vars/stg-env.sh

# Current-context verification
if [[ $CURR_CTXT =~ $ENV ]]; then
echo "Environment is $ENV"
echo " Current context is $CURR_CTXT"
echo ------------------------------------
echo "Date: $datestring"
echo "Environment and context match"
echo ------------------------------------

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

read -p " Enter client name for API retrieval :  " clientName
echo " You have chosen $clientName " 
read -p " Continue? (y/n) " CONT
if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
    echo -------------------------------------------------------------------
    read -p "Confluent Login ? " LOGIN_CONFLUENT
    if [ "$LOGIN_CONFLUENT" = "yes" ] || [ "$LOGIN_CONFLUENT" = "y" ] || [ "$LOGIN_CONFLUENT" = "Y" ] || [ "$LOGIN_CONFLUENT" = "Yes" ]; then
        eval "Login to Confluent Cloud? (Only needed on first run)"
        echo "Login Complete "
    elif [ "$LOGIN_CONFLUENT" = "no" ] || [ "$LOGIN_CONFLUENT" = "n" ] || [ "$LOGIN_CONFLUENT" = "N" ] || [ "$LOGIN_CONFLUENT" = "No" ]; then
        echo ;
    else 
        echo "Exiting.."
fi
    echo "Exporting API-keys for $clientName "
    echo " Confluent Update Notes : "
    echo " Running ... "
echo
    func_progress && eval " confluent api-key list | grep $clientName > nonprod/key-export/$clientName.csv "
    echo "Complete."
    echo " File location: nonprod/key-export/$clientName.csv "
    eval "cat nonprod/key-export/$clientName.csv"
    echo -------------------------------------------------------------------
        echo "Complete..."
else
    echo "Exiting....."
fi


