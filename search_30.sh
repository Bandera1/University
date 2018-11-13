#! /bin/bash

var=`grep -i "bpoAppVersion" /root/website.txt | grep -oE "\"+30+\"" /root/website.txt`

echo -e "$var"






