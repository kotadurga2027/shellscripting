#!/bin/bash
NUMBER=$1
if [ $NUMBER -gt 10]
then
   echo "Given Number $NUMBER is greaterthan 10"
   
else
   echo "Given Number $NUMBER is lessthan to 10"
fi

if [ $NUMBER -lt 10]
then
   echo "Given Number $NUMBER is lessthan 10"
   
else
   echo "Given Number $NUMBER is greaterthan to 10"
fi

if [ $NUMBER -eq 10]
then
   echo "Given Number $NUMBER is equal to 10"
   
else
   echo "Given Number $NUMBER is not equal to 10"
fi

if [ $NUMBER -nq 10]
then
   echo "Given Number $NUMBER is not equal to 10"
   
else
   echo "Given Number $NUMBER is equal to 10"
fi