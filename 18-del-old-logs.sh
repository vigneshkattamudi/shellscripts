#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SCRIPT_DIR="/home/ec2-user/app-logs"

mkdir -p $LOGS_FOLDER
mkdir -p $SCRIPT_DIR

START_TIME=$(date +%s)

if [ $USERID -eq 0 ]
then 
    echo -e "$G User Root $N... Proceed"
else
    echo -e "$R ERR:: Run with Root $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 is ... Success $N"
    else
        echo -e "$R $2 is ... Failure $N"
        exit 1
    fi
}

FILES_TO_DELETE=$(find $SCRIPT_DIR -name "*.log" -mtime +14)

while IFS= read -r file
do
    rm -rf $file
    echo -e "$R $file deleted $N"
done <<< 18-del-old-logs.sh

END_TIME=$(date +%s)
TOTAL_TIME=$(($END_TIME - $START_TIME))

echo -e "Time taken to delete file $G $TOTAL_TIME Seconds $N"