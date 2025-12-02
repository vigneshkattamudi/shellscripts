#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # if DAYS are provided that will be considered, otherwise default 14 days

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGS_FOLDER="/var/log/shell-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/backup.log"

mkdir -p $LOGS_FOLDER

START_TIME=$(date +%s)
echo "Script started Executing at : $(date)" | tee -a $LOG_FILE

check_root(){
    if [ $USERID -eq 0 ]
    then 
        echo -e "$G User Root $N... Proceed" | tee -a $LOG_FILE
    else
        echo -e "$R ERR:: Run with Root $N" | tee -a $LOG_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 is ... Success $N" | tee -a $LOG_FILE
    else
        echo -e "$R $2 is ... Failure $N" | tee -a $LOG_FILE
        exit 1
    fi
}

USAGE(){
    echo -e "$R USAGE:: $N sh Script.sh <source-dir> <destination-dir> <days(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
    exit 1
fi


if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R ERR:: $SOURCE_DIR does not exist"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R ERR:: $DEST_DIR does not exist"
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)
sudo dnf install zip -y

if [ ! -z "$FILES" ]
then
    echo "Files to zip are: $FILES_TO_DELETE"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"

    if [ -f $ZIP_FILE ]
    then
        echo -e "Successfully created Zip file"

        while IFS= read -r filepath
        do
            echo "Deleting file: $filepath" | tee -a $LOG_FILE
            rm -rf $filepath
        done <<< $FILES
        echo -e "Log files older than $DAYS from source directory removed ... $G SUCCESS $N"
    else
        echo -e "Zip file creation ... $R FAILURE $N"
        exit 1
    fi
else
    echo -e "No log files found older than 14 days ... $Y SKIPPING $N"
fi