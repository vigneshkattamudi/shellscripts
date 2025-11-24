#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "Script started executing at:$(date)"

USERID=$(id -u)
if [ $USERID -eq 0 ] 
then 
    echo -e "$G ROOT... Proceed $N" &>>$LOG_FILE
else
    echo -e "$R ERROR... Run with root $N" &>>$LOG_FILE
    exit 1 
fi

LOGS="/var/log/shell-scripts"
SCRIPT_NAME=$( $0 | cut -d "." -f1)
LOG_FILE="$LOGS/$SCRIPT_NAME.log"

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 Installed $N" &>>$LOG_FILE
    else
        echo -e "$R ERR: $2 not installed $N" &>>$LOG_FILE
        exit 1
    fi
}

dnf list installed nginx -y &>>$LOG_FILE
if [ $? -eq 0 ]
then
    echo -e "$Y nginx Already installed... Nothing to do $N" &>>$LOG_FILE
else
    echo -e "$G Going to install nginx $N" &>>$LOG_FILE
    dnf install nginx -y
    VALIDATE $? "nginx"
fi

dnf list installed python3 -y &>>$LOG_FILE
if [ $? -eq 0 ]
then
    echo -e "$Y python3 Already installed... Nothing to do $N" &>>$LOG_FILE
else
    echo -e "$G Going to install python3 $N" &>>$LOG_FILE
    dnf install python3 -y
    VALIDATE $? "python3"
fi