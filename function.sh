#!/bin/bash
userid=$(id -u)
if [ $userid -ne 0 ]
then
    echo "Error:: you are running the script without root access"
else
    echo "You are running the script with root access"
    exit 1
validate(){
    if [ $1 -eq 0 ]
    then
        echo "Installing $2 is... sucsess"
    else
        echo "Installing $2 is ... fail"
        exit 1
    fi
}
dnf list installed mysql
if [ $? -ne 0 ]
then
     echo "Mysql is not nstalled... going to install"
     dnf install mysql -y
     if [ $? -eq 0 ]
     validate $? "Mysql"
else
     echo "Mysql is already installed and no action is pending"
fi
dnf list installed nginx
if [ $? -ne 0 ]
then
     echo "Nginx is not nstalled... going to install"
     dnf install nginx -y
     if [ $? -eq 0 ]
     validate $? "nginx"
else
     echo "Nginx is already installed and no action is pending"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
     echo "python3 is not nstalled... going to install"
     dnf install python3 -y
     if [ $? -eq 0 ]
     validate $? "python3"
     fi
else
     echo "python3 is already installed and no action is pending"
fi