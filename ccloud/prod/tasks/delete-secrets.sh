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
echo " Log into Confluent Cloud. Close browser window and rerun"
eval "confluent login"
echo " waiting ... "
    sleep 3

echo "API-Key name translates to file name containing api-keys"
read -p " Please enter the api key name... " CLIENT_FILE

        KEY_DEL="confluent api-key delete"

echo "Selected file is $CLIENT_FILE.."
echo ---------------------------------------------------------------------------
echo "You have selected the following api-keys to delete: "
eval " cat prod/env/$CLIENT_FILE "
echo ---------------------------------------------------------------------------
read -p  " Is this correct ? (yes/no) " CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
        echo ---------------------------------------------------------------
        echo "Deleting keys .... "
            while read -r line;
            do  
                [[ -n "$line" ]] && yes | eval "confluent api-key delete $line";
            done < "prod/env/$CLIENT_FILE"
        echo ---------------------------------------------------------------
    
    else
        echo " Exiting.....";
    fi
