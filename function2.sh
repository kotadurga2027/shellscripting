#!/bin/bash
userid=$(id -u)
if [ $userid -ne 0 ]
then
    echo "Error:: You are runing the script witout root access"
    exit 1
else
    echo "You are running the script with root access"
fi
validate(){
    if [ $1 -eq 0 ]
    then  
        echo "$2 uninstallation is success"
    else
        echo "$2 uninstallation is failure"
    fi
}
dnf list installed mysql
if [ $? -eq 0 ]
then  
    echo "Mysql is installed and we are going to uninstall"
    dnf remove mysql -y
    validate $? "mysql"
    
else
    echo "Mysql is not installed no need to perform"
fi

dnf list installed nginx
if [ $? -eq 0 ]
then  
    echo "nginx is installed and we are going to uninstall"
    dnf remove nginx -y
    validate $? "nginx"
    
else
    echo "nginx is not installed no need to perform"
fi

dnf list installed python3
if [ $? -eq 0 ]
then  
    echo "python is installed and we are going to uninstall"
    dnf remove python3 -y
    validate $? "python3"
    
else
    echo "python is not installed no need to perform"
fi