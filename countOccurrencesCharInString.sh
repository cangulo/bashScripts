#!/bin/bash
# Bash Script to count the number of occurrences one character into a string

inputString="test,test2,test3"   
char="t"

echo -e "\n## Approach 1: Using tr and wr commands\n"

numOccurrences1=$(tr -dc $char <<< $inputString | wc -c)
echo "The number of occurrences of \"$char\" is $numOccurrences1"

echo -e "\n## Approach 2: Using grep command\n"

numOccurrences2=$(grep -o $char <<< $inputString | grep -c $char)
echo "The number of occurrences of \"$char\" is $numOccurrences2"