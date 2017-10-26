#!/bin/bash

YEAR=$1

#Example "master|dev*|release*"
EXCLUDED_BRANCHES="master|*release*"
INCLUDED_BRANCHES="*|*"

BRANCHES=()

for branch in `git branch -r --merged | sort -r | grep -v HEAD | grep --invert-match --extended-regexp $EXCLUDED_BRANCHES | grep --extended-regexp $INCLUDED_BRANCHES`; do
	if [[ $(echo -e `git show --format="%cI" $branch | head -n 1 | grep $YEAR`) ]]; then
		branch="$(echo $branch | sed 's/origin\// /g')"
		BRANCHES+=($branch)
	fi
done

printf "Removing branches: \n"
for br in ${BRANCHES[@]}; do
	echo "   - $br"
done

echo "Do you want to delete the listed branches?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) DELETE=true; break;;
        No ) DELETE=false; echo "Canceling"; exit;;
    esac
done

for br in ${BRANCHES[@]}; do
	echo "Deleting Branch - $br"
	git push origin --delete $br
done
