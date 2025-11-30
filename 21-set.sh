#!/bin/bash

START_TIME=$(date +%s)

set -e

failure(){
    echo "FAILED AT: $1 $2"
}
trap 'failure "${LINENO}" "${BASH_COMMAND}"' ERR

USERID=$(id -u)
R='\e[31m'
G='\e[32m'
Y='\e[33m'
N='\e[0m'

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) # $(basename )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "nginx" "python3")

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -eq 0 ]
then 
    echo -e "$G User root $N" | tee -a $LOG_FILE
else
    echo -e "$R ERR: Run with root $N" | tee -a $LOG_FILE
fi


#for PACKAGES IN ${PACKAGES[@]}
for item in $@
do
    dnf list iInstalled $item &>>$LOG_FILE
    if [ $? -eq 0 ]
    then
        echo "Already $item installed...Nothing to do" | tee -a $LOG_FILE
    else
        echo "Need to install $item" | tee -a $LOG_FILE
        dnf install $item -y &>>$LOG_FILE
    fi
done 

END_TIME=$(date +%s)
TOTAL_TIME=$(( $END_TIME - $START_TIME ))

echo -e "Script exection completed successfully, $Y time taken: $TOTAL_TIME seconds $N" | tee -a $LOG_FILE