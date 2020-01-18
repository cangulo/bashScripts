#!/bin/bash
# Bash Script to explain how to pass an array from one script to another

array=( "test1" "test2" "test3")

./passArrayBetweenScripts/script2.sh ${array[@]}