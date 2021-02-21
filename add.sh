#! /bin/bash
new_user () {
    echo "Enter name for new user:"
    echo "========================"
    read user
    # open system logs folder
    cd /var/log
    # check if program log folder exists
    if [ -d adduser_log/ ]; then
    # if exists, enter the folder
    cd adduser_log
    else
    # if doesn't exist, create
    mkdir adduser_log
    fi
    # check if program log file exists
    if [ -f adduser_log.txt ]; then
    # if doesn't exist, create log file
    touch adduser_log.txt
    fi
    # check if program error log file exists
    if [ -f adduser_error.txt ]; then
    # if doesn't exist, create error log file
    touch adduser_error.txt
    fi
    # check if entered user exists
    if id "$user" >>/var/log/adduser_log/adduser_log.txt 2>>/var/log/adduser_log/adduser_error.txt; then
    echo "============================="
    # if user exists, print message, than exit
    echo "User already exists, exiting."
    else
    # if doesn't exist, create user
    adduser --gecos 1,1,1,1,1 $user
    fi
}
del_user () {
    echo "====================================="
    echo "Enter the username you want to delete"
    read delete
    # check if entered user exists
    if id $delete >/dev/null 2>&1; then
    # if exists, delete it
    deluser $delete
    else
    # if user doesn't exist, print message
    echo "User not found!"
    fi
    # check if exists entered user Home folder
    if [ -d /home/$delete ]; then
    # if exists, delete it
    rm -r /home/$delete
    else
    # if doesn't exist, print message
    echo "Home directory for $delete not found!"
    fi
}
check_user () {
    echo "Enter Username to check if exists:"
    read username
if id $username >/dev/null 2>&1; then
echo "User $username exists"
sleep .5
ls /home/$username
else
echo "User $username does not exist"
fi
}
sleep .1
# List program choices
echo "=========================================="
echo "Create or delete users, choose what to do:"
echo "=========================================="
echo "1. Add user"
echo "=========================================="
echo "2. Check if username exists"
echo "=========================================="
echo "3. Delete user and it's home directory"
echo "=========================================="
echo "4. Exit"
echo "=========================================="
echo "Enter your choice: 1, 2, 3 or 4"
echo "=========================================="
# and execute chosen one
read choice
case $choice in
1) new_user
;;
2) check_user
;;
3) del_user
;;
*) exit
;;
esac