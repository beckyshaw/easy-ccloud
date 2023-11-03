ENV="confluent-nonprod"
CONTEXT="confluent-nonprod"
CURR_CTXT="$(kubectl config current-context)"
USE_CTXT="$(kubectl config use-context $CONTEXT)"


echo "Environment is $ENV"
echo " Current context is $CURR_CTXT"

if [[ $CURR_CTXT =~ $ENV ]]; then
echo -------------------------------
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