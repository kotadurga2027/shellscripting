#!/bin/bash
userid=(id -u)
if [ $userid -ne 0 ]
then
   echo "Error:: Please run with root access"
   exit 1
else
   echo "You are running with root access"
fi
dnf list installed mysql
if [ $? -ne 0 ]
then
   echo "Mysql is not installed..... going to install the Mysql"
   dnf install mysql -y
   if [ $? -eq 0 ]
   then
      echo "Installing mysql is... sucsess"
   else
      echo "Installing my is ... fail"
      exit 1
   fi
else
   echo "Mysql is already isnatlled no action is pending"
fi
   