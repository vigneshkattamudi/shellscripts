#!/bin/bash

#In this we have learned to assign a value to variable (key = value)
#Variable syntax is VAR=DATA but here VAR=NAME and DATA=INPUT
#Variable names are not case sensetive

PERSON1=vignesh # no space btw and after =
PERSON2=abhi # to call the variable we need to use ($)

#Two ways to access Variables, $varname i.e, $PERSON1 or ${PERSON1}.......
echo $PERSON1 : " Hi $PERSON2, how are you ? "
echo $PERSON2 : " I am good $PERSON2 and you."
echo ${PERSON1} : "what's plans tonight."
echo $PERSON2 : "nothing much. ${PERSON1}"