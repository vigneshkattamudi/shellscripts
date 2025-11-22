#!/bin/bash

PERSON1=$1
person2=$2 #Lower case

#To pass arguments in shell we use special character called "$".
#$1=It reads the First argument
#$2=It reads the Second argument
#We have to give the NAME while executing the shell.

echo $PERSON1 : " Hi $person2, how are you ? "
echo $person2 : " I am good and you."
echo $PERSON1 : "what's plans tonight."
echo $person2 : "nothing much."