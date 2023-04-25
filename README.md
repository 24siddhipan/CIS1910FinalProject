# CIS1910FinalProject
This is a repository for the Final Project Class Tool for CIS1910. The Class Organizer for Git (COG) is described below:

### Description
COG is an automation tool for setting up a folder for a coding class on Eniac. The tool creates a git repo and file structure to store notes and assignments, and
Sets up an individual folder and readme for each assignment. Then, COG can connect seamlessly to Github for repository management. Developed as a Bash script

### Motivation and Design
Unlike other tools, COG is focused on being convenient for students. COG oets up repositories locally and connects to repositories upstream on Github, using a Github account that has been linked via SSH. It then Creates folders for other parts of taking a class like lecture notes. The flexible setup applies to all kinds of assignments and class structures.

### Using the Tool

To Use the tool, ensure the setupTool.sh bash script is in the current directory of the terminal and call the following:

'''
bash setupTool startDir courseName N [githubRepoSSH]
'''
