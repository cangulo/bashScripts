#!/bin/bash
# Bash Script to split an string by an specific character
# and  store the result as an array
# Remarks: to declare an output as array follow the next pattern:
#       arrayName=( CommandWithOutput)  => 
#       1. Note the parenthesis before and after the command
#       2. The CommandWithOutput should return the array objects separated by \n

inputString="test,test2,test3"   
delimiter=","

echo -e "\n## Approach 1: Using tr command\n"

array1=( $(echo $inputString | tr $delimiter "\n") ) 
echo "number of elements in the array1" ${#array1[@]}
for i in ${array1[@]}
do 
    echo $i
done

echo -e "\n## Approach 2: Using awk\n"

array2=( $(echo $inputString | awk -v awk_deli="$delimiter" '{split($0 , awk_array , awk_deli)}; END {for(n in awk_array){ print awk_array[n] }}') )
echo "number of elements in the array2" ${#array2[@]}
for i in ${array2[@]}
do 
    echo $i
done

echo -e "\n## Approach 3: Using Read command\n"
IFS=$delimiter
read -ra array3 <<< "$inputString"
echo "number of elements in the array3" ${#array3[@]}
for i in ${array3[@]}
do 
    echo $i
done