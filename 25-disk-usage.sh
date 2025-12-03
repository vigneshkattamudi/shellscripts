#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
THRESHOLD=1

while IFS= read -r line
do
    USAGE=$(echo $line | awk -F '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F '{print $7F}')
     if [ $USAGE -ge $THRESHOLD ]
    then
        MSG+="High Disk Usage on $PARTITION: $USAGE % <br>" #<br> represents HTML new
    fi
    MSG+=$(echo "High disk usage in": $PARTITION : $USAGE % \n)
done <<< $DISK_USAGE

echo $MSG