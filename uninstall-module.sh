#!/bin/bash
userid=$(id -u)
if [ $userid -ne 0 ]
then
    echo "Error:: You are runing the script witout root access"
    exit 1
else
    echo "You are running the script with root access"
fi
dnf list installed mysql
if [ $? -eq 0 ]
then  
    echo "Mysql is installed and we are going to uninstall"
    dnf remove mysql -y
    if [ $? -eq 0 ]
    then  
        echo "Mysql uninstallation is success"
    else
        echo "Mysql uninstallation is failure"
    fi
else
    echo "Mysql is not installed no need to perform"
fi