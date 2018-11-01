#! /bin/bash

#------------User menu------------
function user_menu()
{
while true;
do
clear
echo -e "\tUser menu\n"
echo -e "1) Create\n"
echo -e "2) Mod\n"
echo -e "3) Delete\n"
echo -e "4) Back\n"

read entered

case $entered in
1)
create_user
;;
2)
mod_user
;;
3)
del_user
;;
4)
main_menu
;;
esac
done
}

function del_user()
{
clear
echo -e "\tDelete user\n"
echo -e "Enter name "
read name

if grep $name /etc/passwd
then
userdel $name
echo -e "Succes\n"
read w
else
echo -e "$name does not exist\n"
read w
fi
}

function mod_user()
{
while true;
do
clear
echo -e "\tModification user\n"
echo -e "1) Name\n"
echo -e "2) UID\n"
echo -e "3) GID\n"
echo -e "4) Password\n"
echo -e "5) Expire\n"
echo -e "6) Comment\n"
echo -e "7) Back\n"

read entered

case $entered in
1)
clear
echo -e "Enter user name "
read user_name
echo -e "Enter new user name "
read new_user_name
if grep $new_user_name /etc/passwd;
then
clear
echo -e "This name alredy taken\n"
read w
else
usermod -l $new_user_mod $user_name
echo -e "Succes\n"
read w
fi
;;
2)
clear 
echo -e "Enter user name "
read user_name
echo -e "Enter new UID "
read new_uid

if grep $new_uid /etc/passwd;
then
clear
echo -e "UID $new_uid alredy taken\n"
read w
else
usermod -u $new_uid $username
echo -e "Oh yea,this operation has been succes\n"
read w
fi
;;
3)
clear
echo -e "Enter user name "
read user_name
echo -e "Enter new GID "
read new_gid

if grep $new_gid /etc/passwd;
then
echo -e "This $new_gid alredy taken\n"
read w
else
usermod -g $new_gid $user_name
echo -e "Succes\n"
read w
fi
;;
4)
clear
echo -e "Enter user name "
read user_name
echo -e "Enter new passwod "
read new_passwd

if grep $new_passwd /etc/passwd;
then
echo -e "This password alredy taken\n"
read w
else
usermod -p $new_passwd $user_name
echo -e "Success\n"
read w
fi
;;
5)
clear
echo -e "Enter user name "
read user_name
echo -e "Enter new expire (year-month-day) "
read new_expire

usermod -e $new_expire $user_name
echo -e "Succes\n"
read w
;;
6)
clear
echo -e "Enter user name "
read user_name
echo -e "Enter new comment "
read new_comment

useradd -c $new_comment $user_name
echo -e "Succes\n"
read w
;;
7)
user_menu
;;
esac
done
}

function create_user()
{
while true;
do
clear
echo -e "\tCreate user\n"
echo -e "1) Default\n"
echo -e "2) Custom\n"
echo -e "3) Back\n"

read entered

case $entered in
1)
clear
echo -e "Enter name "
read user_name
echo -e "Enter password "
read user_password
if grep $user_name /etc/passwd;
then
echo -e "This user alredy exist\n"
read w
else
useradd -p $user_password $user_name                 
echo -e "Succes\n"
read w
fi
;;
2)
create_custom_user
;;
3)
user_menu
;;
esac
done
}

function create_custom_user()
{
clear
echo -e "\tCustom user create"
echo -e "Enter name "
read name
echo -e "Enter UID "
read uid
echo -e "Enter GID "
read gid
echo -e "Enter password "
read password
echo -e "Enter expire "
read expire
echo -e "Enter comment "
read comment

if grep -eo $name -eo $uid -eo $gid /etc/passwd;
then
echo -e "User wasnt create\n"
read w
else
useradd -u $uid -g $gid -p $password -e $expire -c $comment $name
echo -e "User created\n"
read w 
fi
}

#---------Group---------------
function group_menu()
{
while true;
do
clear
echo -e "\tGroup menu\n"
echo -e "1) Create\n"
echo -e "2) Mod\n"
echo -e "3) Delete\n"
echo -e "4) Back\n"

read entered

case $entered in
1)
create_group
;;
2)
mod_group
;;
3)
clear
echo -e "Enter group name"
read groupname
groupdel $groupname
;;
4)
main_menu
;;
esac
done
}

function mod_group()
{
while true;
do
clear
echo -e "\tMod group"
echo -e "1) Change GID"
echo -e "2) Change group name"
echo -e "3) Back"

read entered

case $entered in
1)
clear
echo -e "Enter group name"
read group_name
echo -e "Enter new GID "
read new_gid
groupmod -g $new_gid $groupname
;;
2)
clear
echo -e "Enter group name"
read _group_name
echo -e "Enter new group name"
read new_group_name
groupmod -n $new_group_name $_group_name
;;
3)
group_menu
;;
esac
done
}

function create_group()
{
while true;
do
clear
echo -e "\tCreate group\n"
echo -e "1) Default\n"
echo -e "2) Custom\n"
echo -e "3) Back\n"

read entered

case $entered in
1)
clear
echo -e "\tCreate default\n"
echo -e "Enter name "
read group_name

if grep $group_name /etc/group;
then
echo -e "This name alredy exist\n"
read wai
else
groupadd $group_name
fi
;;
2)
custom_group
;;
3)
group_menu
;;
esac
done
}

function custom_group()
{
clear
echo -e "\tCreate custom group\n"
echo -e "Enter name "
read group_name
echo -e "Enter group id "
read group_id

if grep $group_name /etc/group && grep $group_id /etc/group;
then
echo -e "Error\n"
read wai
else
groupadd -g $group_id $group_name
fi
}
#-------------Main menu-------------

function show_info()
{
while true;
do
clear
echo -e "\tInfo\n"
echo -e "1) Show group info\n"
echo -e "2) Show user info\n"
echo -e "3) Back\n"

read entered

case $entered in
1)
clear
echo -e "\tGroup info\n"
cat /etc/group
read w
;;
2)
echo -e "\tUser info\n"
cat /etc/passwd
read w
;;
3)
main_menu
;;
esac
done
}

function main_menu()
{
while true;
do
clear
echo -e "\tMenu\n"
echo -e "1) Users menu\n"
echo -e "2) Groups menu\n"
echo -e "3) Show info\n"
echo -e "4) Exit\n"

read entered
case $entered in
1)
user_menu
;;
2)
group_menu
;;
3)
show_info
;;
4)
exit
;;
esac
done
}

main_menu
