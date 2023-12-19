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
echo "New context is: $NEW_CTXT"   
echo -------------------------------
fi

echo
echo
echo ---------------------------------------------------------------------------
echo " Datetime: $datestring "
read -p " Please enter the Secret_ID... " SECRET_ID
echo ---------------------------------------------------------------------------

AWSPENDING="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSPENDING"
AWSCURRENT="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSCURRENT"
AWSPREVIOUS="aws secretsmanager  get-secret-value --secret-id $SECRET_ID --version-stage AWSPREVIOUS"


echo ---------------------------------------------------------------------------
echo "You have selected the following: "
echo " Secret_ID : $SECRET_ID "

read -p  " Is this correct ? (yes/no) " CONT
    if [ "$CONT" = "yes" ] || [ "$CONT" = "y" ] || [ "CONT" = "Yes" ]; then
        echo
        echo " Showing all $SECRET_ID keys ... "
        echo
        echo ---------------------------------------------------------------
        echo "AWSPENDING for $SECRET_ID is .... "
        eval "$AWSPENDING | head " 
        echo ---------------------------------------------------------------
        echo "AWSCURRENT for $SECRET_ID is .... "
        eval "$AWSCURRENT | head ";
        echo ---------------------------------------------------------------
        echo "AWSPREVIOUS for $SECRET_ID is .... "
        eval "$AWSPREVIOUS | head ";
        echo ---------------------------------------------------------------

        #     count=0
        #     total=6
        #     start=`date +%s`
        #     while [ $count -lt $total ]; do
        #         sleep 0.5 # this is work
        #         cur=`date +%s`
        #         count=$(( $count + 1 ))
        #         pd=$(( $count * 73 / $total ))
        #         runtime=$(( $cur-$start ))
        #         estremain=$(( ($runtime * $total / $count)-$runtime ))
        #         printf "\r%d.%d%% complete ($count of $total) - est %d:%0.2d remaining\e[K" $(( $count*100/$total )) $(( ($count*1000/$total)%10)) $(( $estremain/60 )) $(( $estremain%60 ))
        #     done
        # printf "\ndone\n"
    
    else
        echo " Exiting.....";
    fi
