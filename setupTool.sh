#!/bin/bash

function errorGuide {
	printf "To use this tool, the user need to provide the course name, number of assignments (N) and GitHub Repo SSH (optional).\nPlease use the function with the following format:\n"
	echo -e "bash setupTool \e[3mstartDir\e[0m \e[3mcourseName\e[0m N [\e[3mgithubRepoSSH\e[0m]"
	printf "Note: Use ~ for the start directory to create the repo in the current directory\n"
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

STARTDIR="$1"
COURSENAME=$2
NUMASSIGN=$3

makeFolderName $COURSENAME

printf "Course Name: $COURSENAME\n"
printf "Number of Assignments: $NUMASSIGN\n\n"

printf "Initializing repo...\n"

# Process Path Info
if [[ $STARTDIR == ~ ]]; then
	GITPATH=$FOLDERNAME
elif [[ $STARTDIR == */ ]]; then
	GITPATH="$STARTDIR$FOLDERNAME"
else
	GITPATH="$STARTDIR/$FOLDERNAME"
fi

git init -b main $GITPATH
printf "Setting up directories...\n"

mkdir "$GITPATH/Notes"
printf "# $COURSENAME Notes\nThis is a folder for storing $COURSENAME notes\n" > "$GITPATH/Notes/README.md"

mkdir "$GITPATH/Assignments"
for file in $(seq -f "%02G" 1 $NUMASSIGN); do
	mkdir "$GITPATH/Assignments/Assignment_$file"
	printf "# Assignment $file for $COURSENAME\n" > "$GITPATH/Assignments/Assignment_$file/README.md"
done

printf "Commiting Changes to Repo\n"
git -C "$GITPATH" add .
git -C "$GITPATH" commit -m "Setup Class Repository"

if [[ $# -eq 4 ]]; then
	SSHCODE=$4
	printf "Your Specified Repo SSH is: $SSHCODE\n"
	git -C "$GITPATH" remote add origin $SSHCODE
	git -C "$GITPATH" push -u origin main
fi

printf "DONE\n"


