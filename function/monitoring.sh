#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
check="authku.servpanel.biz.id/check"
###########- COLOR CODE -##############
NC="\e[0m"
green="\033[0;32m"
red="\033[0;31m"
###########- END COLOR CODE -##########

BURIQ () {
    curl -sS https://${check}/database.ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://${check}/database.ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://${check}/database.ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
O='\033[0;33m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
echo -e ""
echo -e "
${green}Notif By AutoScript Xray-SSH${NC}
--------------------------------------------------------
You IP ( ${red}${MYIP}${NC} ) blocked By AutoScript
${green}The script you are currently using is out of date${NC}
${green}Please contact the admin to extend the duration${NC}
${O}My Telegram :${NC} @WaanSuka_Turu
--------------------------------------------------------
"
echo -e ""
exit 0
fi
#color code
export NC='\033[0m'
export multi='\E[41;1;39m'
export semua='\E[45;1;39m'
export new='\E[45;1;39m'
export cyan='\033[0;36m'
export or='\033[1;33m'
export yl='\e[32;1m'
export rd='\e[31;1m'
export C='\033[0;36m'
export R='\e[31;1m'
export G="\033[0;32m"
export B='\033[0;34m'
export O='\033[0;33m'

function 5m(){
clear
vnstat -5
echo ""
read -n 1 -s -r -p "Enter to back.!!"
monitorbw
}

function hours(){
clear
vnstat -h
echo ""
read -n 1 -s -r -p "Enter to back.!!"
monitorbw
}

function day(){
clear
vnstat -d
echo ""
read -n 1 -s -r -p "Enter to back.!!"
monitorbw
}

function month(){
clear
vnstat -m
echo ""
read -n 1 -s -r -p "Enter to back.!!"
monitorbw
}

# RX = Download
# TX = Upload

clear
tx_now="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
rx_now="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
echo -e "
${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
${multi}             • BANDWIDTH MONITORING •            ${NC}
${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
 ${O}~ Today RX :${NC} $rx_now
 ${O}~ Today TX :${NC} $tx_now"
echo -e "
 ${rd}1.)${NC} Check Usage After 5 Minutes
 ${rd}2.)${NC} Check Usage After 1 Hours
 ${rd}3.)${NC} Check Usage After 1 Days
 ${rd}4.)${NC} Check Usage After 1 Month
"
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo " Tap enter to go back"
echo ""
read -p " Select Options : " select_number
echo -e ""
case $select_number in
1)
5m
;;
2)
hours
;;
3)
day
;;
4)
month
;;
*)
echo -e "" ; sleep 1 ; menu
esac