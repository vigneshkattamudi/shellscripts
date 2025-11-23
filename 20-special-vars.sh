#!/bin/bash

TIMESTAMP=$(date)
echo "Script executed at: $TIMESTAMP"

echo "All variables passed: $@"
echo "No of vars passed: $#"
echo "home dir: $HOME"
echo "present wor dir: $PWD"
echo "script name: $0"
echo "script running by user: $USER"
echo "PID of script: $$"
sleep 10 &
echo "PID of background script: $!"
echo "exit status of last command $?"


USERID=$(id -u)
if [ $USERID -eq 0 ]
then
    echo "user root.. PROCEED"
else
    echo "ERR: Run with root"
    exit 1
fi

VALIDATE(){    #validate function takes input as args in shell
    if [ $? -eq 0 ]
    then
        echo "$2 installed"
    else
        echo "ERR: $2 installation failed"
        exit 1
    fi
}

dnf list installed nginx
if [ $? -eq 0 ]
then
    echo "ngnix Already installed"
else
    echo "Installing ngnix"
    dnf install nginxx -y #
    VALIDATE $? "nginx"
fi

dnf list installed python3
if [ $? -eq 0 ]
then
    echo "python3 Already installed"
else
    echo "Installing python3"
    dnf install python3 -y
    VALIDATE $? "python3"
fi

dnf list installed mysql
if [ $? -eq 0 ]
then
    echo "mysql Already installed"
else
    echo "Installing mysql"
    dnf install mysql -y
    VALIDATE $? "mysql"
fi