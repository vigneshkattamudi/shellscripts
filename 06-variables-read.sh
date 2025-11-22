#!/bin/bash

#we can use arguments in runtime instead of saving
#read command is used to pass arguments in run-time

echo "Enter your pin: "
read -s PIN # here pin is variable
echo "pin is : $PIN "

echo "Please enter your name:"
#The Linux read command is used to read the contents of a line into a variable
read -s USERNAME  # The name entered above will be automatically attached to USERNAME variable. -s will hide the names in terminal
echo "The user name is: $USERNAME" #Prinitng on screen for reference

echo "Please enter your password:"
read -s PASSWORD  
echo "The password is: $PASSWORD" #Prinitng on screen for reference

echo "please enter you job role:"

read jobrole

echo "My jobrole is $jobrole"