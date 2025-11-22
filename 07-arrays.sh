#!/bin/bash

# #We can add multiple values in a single variable using arrays.So memory in the computer can be saved.
# #To comment everything (CTRL+/)

# NAMES=(srinu rani vignesh abhi)

# echo first name : ${NAMES[0]}
# echo second name : ${NAMES[1]}
# echo third name : ${NAMES[2]}

# echo all names : ${NAMES[@]}

# #here srinu = 0, rani= 1, vignesh=2, abhi=3

TIMESTAMP=$(date)
echo "Script started at: $TIMESTAMP"

DEVOPS=("CLOUD" "AWS" "AZURE" "GCP")

echo "First name is: ${DEVOPS[0]}"
echo "Second name is: ${DEVOPS[2]}"
echo "All names is: ${DEVOPS[@]}"