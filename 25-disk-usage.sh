#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
THRESHOLD=1

while IFS= read -r line
do
    USAGE=$(echo $line | awk -F '{ print $6 }' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F '{ print $6 }')
    MSG+=$(echo "High disk usage in": $PARTITION : $USAGE % \n)
done <<< $DISK_USAGE

echo $MSG