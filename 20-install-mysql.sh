#!/bin/bash

# we are going to install mqsql nginx

R="\e[31m"      # Red
G="\e[32m"      # Green
Y="\e[33m"      # Yellow
N="\e[0m"       # Reset

LOGS_FOLDER="/var/logs/shellscript-logs"     # Folder to store logs
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )    # Extract script name without extension
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"     # Define full path for log file

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

dnf list installed mysql &>>$LOG_FILE       # Check if MySQL is installed and log output
if [ $? -eq 0 ]                             # If installed
then
    echo -e "Nothing to do...$Y mysql installed $N" | tee -a $LOG_FILE  # Log already installed
else
    echo -e "NOT installed.. $Y Installing Now $N" | tee -a $LOG_FILE            # Log installation start
    dnf install mysql -y &>>$LOG_FILE                                   # Install MySQL and log
    VALIDATE $? mysql                                                   # Validate installation
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install it" | tee -a $LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "nginx"
else
    echo -e "Nothing to do nginx... $Y already installed $N" | tee -a $LOG_FILE
fi