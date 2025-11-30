#!/bin/bash

R='\e[31m'
G='\e[32m'
Y='\e[33m'
N='\e[34m'

USERID=$(id -u)
if [ $USERID -eq 0 ]
then
    echo -e "$G User root... Proceed $N"
else
    echo -e "$R ERR: Run with root $N"

fi

LOGS="/var/log/rosboshop-logs/"
LOG_FOLDER=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS/$LOG_FOLDER.log"
SCRIPT=$PWD

mkdir -p $LOGS
echo "Script started at $(date)" | tee -a $LOG_FILE

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

