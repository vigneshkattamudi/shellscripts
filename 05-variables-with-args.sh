#!/bin/bash

PERSON1=$1
person2=$2 #Lower case

#To pass arguments in shell we use special character called "$".
#$1=It reads the First argument
#$2=It reads the Second argument
#We have to give the NAME while executing the shell.

echo $PERSON1 : " Hi $person2, Early to bed ok ? "
echo $person2 : " Ok Sir."
echo $PERSON1 : "Bye Good Night."
echo $person2 : "Bye."