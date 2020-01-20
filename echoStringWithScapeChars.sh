#!/bin/bash
#   Echo text with scape characters String With New lines (\n)
#   Set of examples of how create an array from the output of other command

scapeChar=$'\n'
inputText="line1"$scapeChar"line2withlongtextTogether"$scapeChar"line 3 with long text with spaces"

echo -e "\n###    Scenario 1: echo string created START"
echo -e ${inputText}   # echo command doesn't print the new line
echo -e "\n###    Scenario 1: echo string created END"


inputText2="line1\nline2withlongtextTogether\nline 3 with long text with spaces"

echo -e "\n###    Scenario 2: echo string created with scape characters START"
echo -e ${inputText2}   # echo command 
echo -e "\n###    Scenario 2: echo string created with scape characters END"