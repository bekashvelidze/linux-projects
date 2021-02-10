#! /bin/bash
new_user () {
    echo "Enter name for new user:"
    echo "========================"
    read user
    #ვხსნით სისტემის ლოგ საქაღალდეს
    cd /var/log
    #ვამოწმებთ თუ არის თქვენი პროგრამის შესაბამისი ლოგ საქაღალდე
    if [ -d adduser_log/ ]; then
    #თუ არის გადავდივართ ამ საქაღალდეში
    cd adduser_log
    else
    #თუ არ არის ვქმნით
    mkdir adduser_log
    fi
    #ვამოწმებთ არის თუ არა პროგრამის ლოგ ფაილი
    if [ -f adduser_log.txt ]; then
    #თუ არ არის ვქმნით ამ ფაილს
    touch adduser_log.txt
    fi
    #ვამოწმებთ თუ არის პროგრამის შეცდომების ლოგ ფაილი
    if [ -f adduser_error.txt ]; then
    #თუ არ არის ვქმნით
    touch adduser_error.txt
    fi
    #ვამოწმებთ თუ არის სისტემაში მომხმარებლის მიერ მითითებული მომხმარებელი
    if id "$user" >>/var/log/adduser_log/adduser_log.txt 2>>/var/log/adduser_log/adduser_error.txt; then
    echo "============================="
    #თუ არის გამოგვაქ შეტყობინება ამის შესახებ
    echo "User already exists, exiting."
    else
    #თუ არ არის ვქმნით
    adduser --gecos 1,1,1,1,1 $user
    fi
}
del_user () {
    echo "====================================="
    echo "Enter the username you want to delete"
    read delete
    #ვამოწმებთ თუ არის მომხმარებლის მიერ მითითებული მომხმარებელი
    if id $delete >/dev/null 2>&1; then
    #თუ არის ვშლით
    deluser $delete
    else
    #თუ არაა გამოგვაქ შეტყობინება ამის შესახებ
    echo "User not found!"
    fi
    #ვამოწმებთ თუ არის მომხმარებლის მიერ მითითებული მომხმარებლის Home საქაღალდე
    if [ -d /home/$delete ]; then
    #თუ არის ვშლით
    rm -r /home/$delete
    else
    #თუ არ არის გამოგვაქ შეტყობინება ამის შესახებ
    echo "Directory not found!"
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
#გამოგვაქვს პროგრამის ფუნქციების არჩევანი
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
#და ვასრულებთ არჩეულს
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