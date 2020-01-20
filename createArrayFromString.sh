#!/bin/bash
#   Create array from strings
#   Set of examples of how create an array from the output of other command

scapeChar=$'\n'
inputText="line1"$scapeChar"line2withlongtextTogether"$scapeChar"line 3 with long text with spaces"

echo -e "\n###    Scenario 1: create an array by splitting by spaces or \\\n START"

arrayBySpaces=($inputText)
for part in ${arrayBySpaces[@]}; do
    echo $part
done

echo -e "\n###    Scenario 2: create an array by splitting by \\\n START"

IFS=$'\n'
arrayByNewLine=($inputText)
for part in "${arrayByNewLine[@]}"; do
    echo $part
done