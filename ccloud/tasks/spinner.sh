#!/bin/bash

function func_spinner() {
for((i=0;i<=100;i+=3)); do
    printf "%-*s" $((i+1)) '[' | tr ' ' '#'
    printf "%*s%3d%%\r"  $((101-i))  "]" "$i"
    sleep 0.3
done; echo
}

func_spinner 5 && echo "done"