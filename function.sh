#!/bin/bash
userid=$(id -u)
if [ $userid -ne 0 ]
then
    echo "Error:: you are running the script without root access"
    exit 1
else
    echo "You are running the script with root access"
fi
    
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
     validate $? "Mysql"
     
else
    echo "Mysql is already installed and no action is pending"
fi
dnf list installed nginx
if [ $? -ne 0 ]
then
     echo "Nginx is not nstalled... going to install"
     dnf install nginx -y
     validate $? "nginx"
     
else
     echo "Nginx is already installed and no action is pending"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
     echo "python3 is not nstalled... going to install"
     dnf install python3 -y
     
     validate $? "python3"
     
else
     echo "python3 is already installed and no action is pending"
fi