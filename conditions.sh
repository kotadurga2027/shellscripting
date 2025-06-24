#!/bin/bash
number=$1
if[$number -lt 10]
then
   echo "Given number $number is lessthen 10"
else
   echo "Given number $number is greaterthen 10"
fi