#!/bin/bash
#
# small script to update the default branch for all projects

if [ -z $1 ] || [ -z $2 ]; then
  echo ""
  echo "************************************************************************************"
  echo "*                                                                                  *"
  echo "* Usage: ./update-default-branch.sh <project list> <branch name>                   *"
  echo "* Example: ./update-default-branch.sh project-list android-7.0                     *"
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
    echo " BRANCH NAME: {$2}"
    echo "====================================================================="
    echo ""

    curl -u jakew02 -d "{\"name\":\"$project\", \"default_branch\":\"$2\"}" https://api.github.com/repos/jakew02/$project

done < project-list

