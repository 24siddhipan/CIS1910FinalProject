#!/bin/bash

function errorGuide {
	printf "To use this tool, the user need to provide the course name, number of assignments (N) and GitHub Repo SSH (optional).\nPlease use the function with the following format:\n"
	echo -e "bash setupTool \e[3mstartDir\e[0m \e[3mcourseName\e[0m N [\e[3mgithubRepoSSH\e[0m]"
	exit 1
}

function makeFolderName {
	rawMonth=$(date +'%m')
	rawYear=$(date +'%Y')

	if [[ $rawMonth -le 5 ]]; then
		FOLDERNAME="$1_Spring_$rawYear"
	elif [[ $rawMonth -le 8 ]]; then
	        FOLDERNAME="$1_Summer_$rawYear"
	else
	        FOLDERNAME="$1_Fall_$rawYear"
	fi
}

# Check for Valid Inputs
if [[ $# -le 2 ]]; then
	printf "Error: Invalid Number of Arguments\n"
	errorGuide
fi

if [[ -z $(echo "$3" | grep -E "^[0-9]+$") ]]; then
	printf "Error: Second Argument Not a Number\n"
	errorGuide
fi

STARTDIR="$1/"
COURSENAME=$2
NUMASSIGN=$3

makeFolderName $COURSENAME

printf "Course Name: $COURSENAME\n"
printf "Number of Assignments: $NUMASSIGN\n\n"
printf "Initializing repo...\n"

#mkdir "$STARTDIR$FOLDERNAME"
git init -b main "$STARTDIR$FOLDERNAME"
printf "Setting up directories...\n"

mkdir "$STARTDIR$FOLDERNAME/Notes"
mkdir "$STARTDIR$FOLDERNAME/Assignments"
for file in $(seq -f "%02G" 1 $NUMASSIGN); do
	mkdir "$STARTDIR$FOLDERNAME/Assignments/Assignment_$file"
	printf "# Assignment $file\n" > "$STARTDIR$FOLDERNAME/Assignments/Assignment_$file/README.md"
done


