#!/bin/bash

TIMESTAMP=$(date)
echo "Script executed at: $TIMESTAMP"

USERID=$(id -u)

if [ $USERID -eq 0 ]
then
    echo "User Root... Proceed"
else
    echo "Error: Run with root"
    exit 1
fi 

dnf list installed nginx
if [ $? -eq 0 ]
then
    echo "Nginx Already installed"
else
    echo "Installing nginx"
    dnf install nginx -y
    if [ $? -eq 0 ]
    then
        echo "Nginx installation Success"
    else
        echo "Installation failed"
        exit 1
    fi 
fi 
