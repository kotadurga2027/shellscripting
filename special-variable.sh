#!/bin/bash
echo "all variables passed to the script:$@"
echo "number of variable:$#"
echo "script name:$0"
echo "current directory:$PWD"
echo "user running this script:$USER"
echo "Home directory of users: $HOME"
echo "PID of the script:$$"
sleep 10 &
echo "PID of last command in background:$!"