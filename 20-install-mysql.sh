#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/logs/shellscript-logs"     # Folder to store logs
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )    # Extract script name without extension
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"     # Define full path for log file
PACKAGES=("mysql" "nginx" "python3")

mkdir -p $LOGS_FOLDER                         # Create logs directory if it doesn't exist
echo "Script started Executing at : $(date)" | tee -a $LOG_FILE   # Log script start time

USERID=$(id -u)                               # Get current user ID
if [ $USERID -eq 0 ]                          # Check if user is root
then
    echo -e "User is root...$G Proceed $N" | tee -a $LOG_FILE      # If root, log and continue
else
    echo -e "$R ERROR : Run with Root $N " | tee -a $LOG_FILE      # If not root, log error
    exit 1                                                          # Exit script
fi

VALIDATE(){                                                    # Function to validate commands
if [ $1 -eq 0 ]                                                 # Check exit status
then
    echo -e "Installing $2...$G SUCCESS $N" | tee -a $LOG_FILE  # Log success message
else
    echo -e "INSTALLATION $2..$R FAILED $N" | tee -a $LOG_FILE  # Log failure message
    exit 1                                                      # Exit script
fi
}

for package in ${PACKAGES[@]}
do 
    dnf list installed $package &>>$LOG_FILE       # Check if MySQL is installed and log output
    if [ $? -eq 0 ]                             # If installed
    then
        echo -e "Nothing to do...$Y $package installed $N" | tee -a $LOG_FILE  # Log already installed
    else
        echo "$package NOT installed.. Installing Now" | tee -a $LOG_FILE            # Log installation start
        dnf install mysql -y &>>$LOG_FILE                                   # Install MySQL and log
        VALIDATE $? $package                                                   # Validate installation
    fi
done