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
echo "New context is: $NEW_CTXT"   
echo -------------------------------
fi

echo ---------------------------------------------------------------------------
echo " Datetime: $datestring "
echo " Logging into Confluent Cloud"
eval "confluent login"
    sleep 5
echo "API-Key name translates to file name containing api-keys"
read -p " Please enter the api key name... " CLIENT
API_KEY="$KEY_DIR$CLIENT"
echo ---------------------------------------------------------------------------
echo "You have selected the following api-keys to delete: "
eval " cat $API_KEY "
echo ---------------------------------------------------------------------------
read -p  " Is this correct ? (yes/no) " CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
        echo ---------------------------------------------------------------
        echo "Key/s deleting .... "
            while read -r line
            do  
                [[ -n "$line" ]] && yes | eval $DELETE_KEY $line 
            done < $API_KEY
        echo ---------------------------------------------------------------
    
    else
        echo " Exiting.....";
    fi
