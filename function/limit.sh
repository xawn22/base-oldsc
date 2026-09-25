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
# // My Code
limit_down=$(cat /etc/mylimit/limit_download.txt)
limit_up=$(cat /etc/mylimit/limit_upload.txt)

#/ Start Limit Speed
function start(){
clear
echo -e "${O}
 Example :
 1024 For 1 Mbps
 2048 For 2 Mbps${NC}
"
read -p "Input Limit Download : " down
sleep 0.1
read -p "Input Limit Upload   : " up
wondershaper -a eth0 -d $down -u $up
sleep 1
clear
echo -e "${yl}Limit Speed Server Success Started.!!${NC}"
sleep 0.5
mkdir -p /etc/mylimit
echo "${up}" >/etc/mylimit/limit_upload.txt
echo "${down}" >/etc/mylimit/limit_download.txt
echo ""
read -n 1 -s -r -p "Enter to back.!!"
limit
}

#/ Stop Limit Speed
function stop(){
clear
echo -e "
Processing... stop limit speed"
sleep 1
echo "1"
sleep 1
echo "2"
sleep 1
echo "3"
sleep 3
clear
wondershaper -c -a eth0
echo -e "${yl}Successfuly.. stop limit speed${NC}"
rm -rf /etc/mylimit
echo ""
read -n 1 -s -r -p "Enter to back.!!"
limit
}

#/ Change Limit Spees
function edit(){
clear
wondershaper -c -a eth0
echo -e "${O}
 Example :
 1024 For 1 Mbps
 2048 For 2 Mbps${NC}
"
read -p "Change Limit Download : " down_change
sleep 0.1
read -p "Change Limit Upload   : " up_change
sleep 0.5
wondershaper -a eth0 -d $down_change -u $up_change
sleep 2
clear
echo -e "${yl}Change Limit Speed Successfully.!!${NC}"
rm -rf /etc/mylimit/limit_upload.txt
rm -rf /etc/mylimit/limit_download.txt
echo "${up_change}" >/etc/mylimit/limit_upload.txt
echo "${down_change}" >/etc/mylimit/limit_download.txt
echo ""
read -n 1 -s -r -p "Enter to back.!!"
limit
}
#//
clear

echo -e "
${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
${multi}               • LIMIT SPEED SERVER •              ${NC}
${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}
 ${O}~ Limit Download :${NC} ${limit_down} kbps
 ${O}~ Limit Upload   :${NC} ${limit_up} kbps"
echo -e "
 ${rd}1.)${NC} Start Limit Speed Server
 ${rd}2.)${NC} Stop Limit Speed Server
 ${rd}3.)${NC} Change Limit Speed Server"
echo -e "
${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "Tap enter to go back menu"
echo ""
read -p "Select Options : " limit_select
echo -e ""
case $limit_select in
1)
start
;;
2)
stop
;;
3)
edit
;;
*)
echo -e "" ; sleep 1 ; menu
esac

