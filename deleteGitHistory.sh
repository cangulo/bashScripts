#!/bin/bash
echo -e "\nSCRIPT TO DELETE THE COMMIT HISTORY - PLEASE EXECUTE IT IN THE REPOSITORY ROOT FOLDER\n"

echo -e "\nSTARTING\n"

git checkout --orphan temp_branch
git add -A
git commit -am "INIT"
git branch -D master
git branch -m master
git push -f origin master

echo -e "\nFINISHED\n"

echo -e "\nPLEASE, TO PROCEED PUSH YOUR LOCAL BRANCH\n"