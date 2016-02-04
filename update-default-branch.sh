#!/bin/bash
#
# small script to update the default branch for all projects

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  echo ""
  echo "************************************************************************************"
  echo "*                                                                                  *"
  echo "* Usage: ./update-default-branch.sh <project list> <github username> <branch name> *"
  echo "* Example: ./update-default-branch.sh jakew02 android-6.0                          *"
  echo "*                                                                                  *"
  echo "************************************************************************************"
  echo ""

  exit 0
fi

while read file;
    do

    rm -rf .tmp
    echo "$file" > .tmp

    project=`cat .tmp | awk '{print $1}'`

    echo ""
    echo "====================================================================="
    echo " PROJECT NAME: {$project}"
    echo " BRANCH NAME: {$3}"
    echo "====================================================================="
    echo ""

    curl -u $2 -d "{\"name\":\"$project\", \"default_branch\":\"$3\"}" https://api.github.com/repos/jakew02/$project

done < project-list

