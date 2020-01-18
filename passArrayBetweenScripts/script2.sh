#!/bin/bash
# Bash Script where an array is received as parameter

a=( $@ )
echo "Number of elements received: ${#a[@]}"
echo "script2: input received in the next line"
for i in ${a[@]}; do
    echo "script2:"$i
done
echo "script2: finish the input received"