#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p LOGS_FOLDER

LOGS_FOLDER="/var/log/shell-scripts"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOG_FILE=$($LOGS_FOLDER/$SCRIPT_NAME.log)
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e " $G $2 installed $N"
    else
        echo -e " $R $2 installation FAILED $N"
        exit 1
    fi
}

echo "Script executed at: $(date)"  &>> $LOG_FILE

USERID=$(id -u)
if [ $USERID -eq 0 ]
then
    echo -e "User is Root $G Proceed $N, So install MySQL" &>> $LOG_FILE
else
    echo -e "ERR: $R User is not root user $N, Run with Root" &>> $LOG_FILE
    exit 1 # other than zero is failure
fi

dnf list installed mysql &>> $LOG_FILE
if [ $? -eq 0 ]
then
    echo -e " $Y Already MySQL installed...Nothing to do $N" &>> $LOG_FILE
else
    echo "Need to install MySQL" &>> $LOG_FILE
    dnf install mysql -y
    VALIDATE $? "mysql" &>> $LOG_FILE
fi

dnf list installed nginx
if [ $? -eq 0 ]
then
    echo -e " $Y Already nginx installed...Nothing to do $N" &>> $LOG_FILE
else
    echo "Need to install nginx" &>> $LOG_FILE
    dnf install nginx -y
    VALIDATE $? "nginx" &>> $LOG_FILE
fi

dnf list installed python3
if [ $? -eq 0 ]
then
    echo -e  "$Y Already python3 installed...Nothing to do $N" &>> $LOG_FILE
else
    echo "Need to install python3" &>> $LOG_FILE
    dnf install python3 -y
    VALIDATE $? "python3" &>> $LOG_FILE
fi
#Reverse of if indicates ending of condition.
#Shell script won't stop if it faces errors, all other languages will stop. 
#So we use exit status command to check previous command is success or not.
#Shell script will store the command output in exit status and Command for exit status is $?.