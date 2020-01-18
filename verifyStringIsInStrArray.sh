#!/bin/bash
# Bash Script to verify is an string is in the list of string of an array
# Remarks: to declare an output as array follow the next pattern:
#       arrayName=( CommandWithOutput)  => 
#       1. Note the parenthesis before and after the command
#       2. The CommandWithOutput should return the array objects separated by \n

array=( "test" "test2" "test3" )
inputValue="test25"

echo -e "\n## Array\n"
for object in ${array[@]}
do
    echo $object
done

echo -e "\n## Approach: execute if and compare each element against the one we want to verify\n"

if [[ "${array[*]}" == *$inputValue* ]]; then
    echo "array: \"${array[@]}\" contains \"$inputValue\""
else
    echo "array: \"${array[@]}\" does NOT contains \"$inputValue\""
fi
