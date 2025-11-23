#!/bin/bash

# Print all variables passed as arguments to the script
echo "All variables passed to the script: $@"

# Print the number of arguments passed to the script
echo "Number of variables passed to the script: $#"

# Print the name of the script itself
echo "script name: $0"

# Print the current working directory
echo "current directory: $PWD"

# Print the username of the person running the script
echo "user running the script: $USER"

# Print the home directory of the user
echo "Home Directory of user: $HOME"

# Print the process ID (PID) of the current script
echo "process instance ID of the script: $$"

# Run a sleep command in the background (10 seconds)
sleep 10 &

# Print the PID of the last command run in the background
echo "PID of the last script in background: $!"

# Print the exit status of the last executed command
# (This will reflect the status of 'echo', not the background job)
echo "Exit Status of Last Script: $?"
