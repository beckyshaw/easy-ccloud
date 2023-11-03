#!/bin/bash# Prompt user to insert inputs (one at a time) read -p 'Enter Number 1: ' number1 
read -p 'Enter Number 2: ' number2 
# Firstly Validate if any input field is left blank. If an input field is left blank, display appropriate message and stop execution of script if [ -z "$number1" ] || [ -z "$number2" ] 
then 
    echo 'Inputs cannot be blank please try again!' 
    exit 0 
fi 
# Now Validate if the user input is a number using regex (Integer or Float). If not, display appropriate message and stop execution of script 
if ! [[ "$number1" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] || ! [[ "$number2" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] 
then 
    echo "Inputs must be a numbers" 
    exit 0 
fi