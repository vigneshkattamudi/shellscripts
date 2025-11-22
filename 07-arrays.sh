#!/bin/bash

# #We can add multiple values in a single variable using arrays.So memory in the computer can be saved.
# #To comment everything (CTRL+/)

TIMESTAMP=$(date)
echo "Script started at: $TIMESTAMP"

DEVOPS=("CLOUD" "AWS" "AZURE" "GCP")

echo "First name is: ${DEVOPS[0]}"
echo "Second name is: ${DEVOPS[2]}"
echo "All names is: ${DEVOPS[@]}"

# Here Cloud = 0, Aws= 1, Azure=2, gcp=3