#!/bin/bash
userid=$(id -u)
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
   echo "Mysql is installed..... going to uninstall the Mysql"
   dnf remove mysql -y
   if [ $? -eq 0 ]
   then
      echo "Uninstalling mysql is... sucsess"
   else
      echo "Uninstalling mysql is ... fail"
      exit 1
   fi
else
   echo "Mysql is not installed no action is pending"
fi
   