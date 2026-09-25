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
export multi='\E[44;1;39m'
export multi1='\E[41;1;39m'
export cyan='\033[0;36m'
export or='\033[1;33m'
export yl='\e[32;1m'
export rd='\e[31;1m'
export C='\033[0;36m'
export R='\e[31;1m'

function create(){
clear
domain=$(cat /etc/xray/domain)
clear
echo -e "
${yl}======================================${NC}
  ${or}Please Input Username & Password
     Or Exit Tap ( CTRL + C )${NC}
${yl}======================================${NC}"
echo ""
read -p "$( echo -e "${rd}=>${NC} ${C}Input Username :${NC} ")" Login
read -p "$( echo -e "${rd}=>${NC} ${C}Input Password :${NC} ")" Pass
read -p "$( echo -e "${rd}=>${NC} ${C}Input Expired  :${NC} ")" masaaktif

IP=$(wget -qO- ipinfo.io/ip);
ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket HTTP" | cut -d: -f2|sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
systemctl restart ws-tls
systemctl restart ws-nontls

useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "${C}Wait.. Sett Up Accounts${NC}"
sleep 1
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
clear
echo -e ""
echo -e "Account Created Successfully"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "°Username : $Login"
echo -e "°Password : $Pass"
echo -e "°Created : $hariini"
echo -e "°Expired : $expi"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "City : $cityinfo"
echo -e "Domain : ${domain}"
echo -e "Port Ws None Tls : $ws2"
echo -e "Port Ws Tls : $ws"
echo -e "Port Dropbear : 143, 109"
echo -e "Port SSH UDP: 1-65535"
echo -e "Port Stunnel :$ssl"
echo -e "Port Squid :$sqd"
echo -e "Port Dropbear Ohp : 8282"
echo -e "Port OpenVpn Ohp : 8383"
echo -e "Port Ssh Ohp : 8181"
echo -e "Port OpenVPN WS : 2086"
echo -e "Port OpenVPN SSL : 990"
echo -e "Port OpenVPN UDP : 2200"
echo -e "Port OpenVPN TCP : 1194"
echo -e "Port UDPGW : 7100 - 7300"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "•Link Config OpenVPN•"
echo -e "TCP: http://${domain}:89/tcp.ovpn"
echo -e "UDP: http://${domain}:89/udp.ovpn"
echo -e "SSL: http://${domain}:89/ssl.ovpn"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
}

function trial(){
clear
source /var/lib/fsidvpn/ipvps.conf
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP2
fi
clear
IP=$(wget -qO- ipinfo.io/ip);
ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket HTTP" | cut -d: -f2|sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
Login=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
clear
systemctl restart ws-tls
systemctl restart ws-nontls
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "${C}Wait.. Sett Up Accounts${NC}"
sleep 1
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
clear
echo -e ""
echo -e "Account Created Successfully"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "°Username : $Login"
echo -e "°Password : $Pass"
echo -e "°Created : $hariini"
echo -e "°Expired : $expi"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "City : $cityinfo"
echo -e "Domain : ${domain}"
echo -e "Port Ws None Tls : $ws2"
echo -e "Port Ws Tls : $ws"
echo -e "Port Dropbear : 143, 109"
echo -e "Port SSH UDP: 1-65535"
echo -e "Port Stunnel :$ssl"
echo -e "Port Squid :$sqd"
echo -e "Port Dropbear Ohp : 8282"
echo -e "Port OpenVpn Ohp : 8383"
echo -e "Port Ssh Ohp : 8181"
echo -e "Port OpenVPN WS : 2086"
echo -e "Port OpenVPN SSL : 990"
echo -e "Port OpenVPN UDP : 2200"
echo -e "Port OpenVPN TCP : 1194"
echo -e "Port UDPGW : 7100 - 7300"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "•Link Config OpenVPN•"
echo -e "TCP: http://${domain}:89/tcp.ovpn"
echo -e "UDP: http://${domain}:89/udp.ovpn"
echo -e "SSL: http://${domain}:89/ssl.ovpn"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
}

function renew(){
clear
read -p "Username : " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Day Extend : " Days
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
showexp=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e ""
echo -e "════════════════════════════════════════════════════" | lolcat
echo -e " ☞ Username     :  $User"
echo -e " ☞ Days Added   :  $Days Days"
echo -e " ☞ Expired On   :  $showexp"
echo -e " ${C}Rennewall accounts succesfuly.!!${NC}"
echo -e "════════════════════════════════════════════════════" | lolcat
else
clear
echo -e ""
echo -e "======================================" | lolcat
echo -e "        ${R}Username Doesnt Exist${NC}        "
echo -e "======================================" | lolcat
fi
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
}

function hapus(){
clear
echo -e "---------------------------------------------------"
echo -e "${O}USERNAME          EXP DATE          STATUS${NC}"
echo -e "---------------------------------------------------"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "=> $AKUN" "$exp     " "LOCKED"
else
printf "%-17s %2s %-17s %2s \n" "=> $AKUN" "$exp     " "UNLOCKED"
fi
fi
done < /etc/passwd
ttl="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "---------------------------------------------------"
echo -e ""
read -p "Input Username => " Pengguna
read -p "Reason/Alasan => " warn

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna
clear
echo -e "
════════════════════════════════════════════════════" | lolcat
echo -e " ☞ Username       : $Pengguna
 ☞ Status         : Hapus/Banned
 ☞ Dihapus Pada   : ${biji}
 ☞ Reason/Alasan  : $warn"
echo -e "════════════════════════════════════════════════════" | lolcat
echo -e ""
else
echo -e "
============================================
      Username ${R}$Pengguna${NC} Tidak Ada.!!
============================================"
echo -e ""
fi
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
}

function cek(){
clear
echo " "
echo " "

if [ -e "/var/log/auth.log" ]; then
        LOG="/var/log/auth.log";
fi
if [ -e "/var/log/secure" ]; then
        LOG="/var/log/secure";
fi
                
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${multi}             ${rd}Dropbear User Online/Login            ${NC}";  
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "    ${or}ID  |  Username  |  IP Address${NC}";
echo -e ""
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/login-db.txt;
for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "dropbear\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $10}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $12}'`;
        if [ $NUM -eq 1 ]; then
                echo -e "${yl}☞${NC} $PID - $USER - $IP";
                fi
done
echo " "
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${multi}             ${rd}OpenSSH User Online/Login             ${NC}";  
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "    ${or}ID  |  Username  |  IP Address${NC}";
echo -e ""
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/login-db.txt
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "sshd\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $9}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
                echo -e "${yl}☞${NC} $PID - $USER - $IP";
        fi
done
if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${multi}              ${rd}OpenVPN TCP User Login               ${NC}";  
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${or}Username  |  IP Address  |  Connected${NC}";
echo -e ""
        cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
fi

if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
echo " "
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${multi}              ${rd}OpenVPN UDP User Login               ${NC}";  
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${or}Username  |  IP Address  |  Connected${NC}";
echo -e ""
        cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
fi
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo "";
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
}

function exp(){
clear
               hariini=`date +%d-%m-%Y`
               cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
               totalaccounts=`cat /tmp/expirelist.txt | wc -l`
               for((i=1; i<=$totalaccounts; i++ ))
               do
               tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
               username=`echo $tuserval | cut -f1 -d:`
               userexp=`echo $tuserval | cut -f2 -d:`
               userexpireinseconds=$(( $userexp * 86400 ))
               tglexp=`date -d @$userexpireinseconds`             
               tgl=`echo $tglexp |awk -F" " '{print $3}'`
               while [ ${#tgl} -lt 2 ]
               do
               tgl="0"$tgl
               done
               while [ ${#username} -lt 15 ]
               do
               username=$username" " 
               done
               bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
               echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >> /usr/local/bin/alluser
               todaystime=`date +%s`
               if [ $userexpireinseconds -ge $todaystime ] ;
               then
		    	:
               else
echo -e "---------------------------------------------"
echo -e "Username   => $username"
echo -e "Expired    => $tgl $bulantahun"
echo -e "Deleted On => $hariini"
echo -e "---------------------------------------------"
echo -e ""
               userdel $username
               fi
               done
               echo "Success Deleted Expiry Account"
               echo -e ""
               read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
               menu-ssh
}
function list(){
clear
echo -e "---------------------------------------------------"
echo -e "${O}USERNAME          EXP DATE          STATUS${NC}"
echo -e "---------------------------------------------------"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "=> $AKUN" "$exp     " "Locked"
else
printf "%-17s %2s %-17s %2s \n" "=> $AKUN" "$exp     " "Unlocked"
fi
fi
done < /etc/passwd
ttl="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "---------------------------------------------------"
echo -e " Total Accounts SSH : $ttl"
echo -e "---------------------------------------------------"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
}

function limit(){
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
clear
echo " "
echo -e "${ORANGE}[√] • Auto delete log user multilogin${NC}";
echo -e "${ORANGE}[√] • Time auto delete log : 09:00:00${NC}";
echo -e "${ORANGE}[√] • Today Time           : ${todaytime}${NC}";
echo -e "${CYAN}───────────────────────────────────────────────${NC}";
if [ -e "/root/log-limit.txt" ]; then
echo -e "${multi}        List of users who do multi-login       ${NC}";
echo -e "${CYAN}───────────────────────────────────────────────${NC}";
cat /root/log-limit.txt
else
echo " User Multilogin No Detected.!!"
echo " "
echo " or"
echo " "
echo " Autokill Script Not Been Executed."
fi
echo -e "${CYAN}───────────────────────────────────────────────${NC}";
echo " ";
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
}

function kil(){
# ==========================================
# Color
r='\033[0;31m'
nc='\033[0m'
g='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}Running ( ON )${Font_color_suffix}"
Error="${Red_font_prefix}Disable ( OFF )${Font_color_suffix}"
cek=$(grep -c -E "^# Autokill" /etc/cron.d/tendang)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e ""
echo -e "${CYAN}───────────────────────────────────────────────${NC}"
echo -e " ${multi}               ${rd}AUTOKILL MENU                 ${NC}"
echo -e "${CYAN}───────────────────────────────────────────────${NC}"
echo -e " Autokill Is : $sts"
echo ""
echo -e " ${r}1.)${nc} AutoKill After 1 Minutes"
echo -e " ${r}2.)${nc} AutoKill After 3 Minutes"
echo -e " ${r}3.)${nc} AutoKill After 5 Minutes"
echo -e " ${r}4.)${nc} Off Autokill Multilogin"
echo -e "${CYAN}───────────────────────────────────────────────${NC}"
echo -e " Press enter to return to the menu"                                                                        
echo -e ""
read -p "Input Your Choose :  " AutoKill
echo -e ""
case $AutoKill in
1)
echo -e ""
read -p "$( echo -e "${r}=>${nc} ${g}Input Limit Allowed :${nc}") " max
sleep 1
clear
echo > /etc/cron.d/tendang
echo "# Autokill" >>/etc/cron.d/tendang
echo "*/1 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
echo "0 9 * * * root rm -rf log-limit.txt" >>/etc/cron.d/tendang
echo -e ""
echo -e "${r}┌────────────────────────────────────┐${nc}"
echo -e ""
echo -e "      ${g}Login Allowed   :${nc} $max Client"
echo -e "      ${g}AutoKill Every  :${nc} 1 Minutes"      
echo -e ""
echo -e "${r}└────────────────────────────────────┘${nc}"                                                                                                                                 
echo ""
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
;;
2)
echo -e ""
read -p "$( echo -e "${r}=>${nc} ${g}Input Limit Allowed :${nc}") " max
sleep 1
clear
echo > /etc/cron.d/tendang
echo "# Autokill" >>/etc/cron.d/tendang
echo "*/3 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
echo "0 9 * * * root rm -rf log-limit.txt" >>/etc/cron.d/tendang
echo -e ""
echo -e "${r}┌────────────────────────────────────┐${nc}"
echo -e ""
echo -e "      ${g}Login Allowed   :${nc} $max Client"
echo -e "      ${g}AutoKill Every  :${nc} 3 Minutes"      
echo -e ""
echo -e "${r}└────────────────────────────────────┘${nc}"
echo ""
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
;;
3)
echo -e ""
read -p "$( echo -e "${r}=>${nc} ${g}Input Limit Allowed :${nc}") " max
sleep 1
clear
echo > /etc/cron.d/tendang
echo "# Autokill" >>/etc/cron.d/tendang
echo "*/5 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
echo "0 9 * * * root rm -rf log-limit.txt" >>/etc/cron.d/tendang
echo -e ""
echo -e "${r}┌────────────────────────────────────┐${nc}"
echo -e ""
echo -e "      ${g}Login Allowed   :${nc} $max Client"
echo -e "      ${g}AutoKill Every  :${nc} 5 Minutes"      
echo -e ""
echo -e "${r}└────────────────────────────────────┘${nc}"
echo ""
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
;;
4)
clear
echo > /etc/cron.d/tendang
echo -e ""
echo -e "${g}======================================${nc}"
echo -e ""
echo -e "    ${r}AutoKill MultiLogin Turned Off${nc}  "
echo -e ""
echo -e "${g}======================================${nc}"
rm -rf log-limit.txt
echo ""
read -n 1 -s -r -p "Tap Enter To Back Menu-SSH"
menu-ssh
;;
*)
menu-ssh
;;
esac
}
clear
# // Status ws tls
ssh_ws=$( systemctl status ws-nontls | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    ws="${green}Running | Normal${NC}"
else
    ws="${rd}Stopped | Error${NC}"
fi


# // Status ws tls
ssh_ws=$( systemctl status ws-tls | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    wstls="${green}Running | Normal${NC}"
else
    wstls="${rd}Stopped | Error${NC}"
fi

echo ""
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e " ${multi}                 ${rd}SSH & OPENVPN MENU                  ${NC}"
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e " SSH WS NONE TLS : $ws"
echo -e " SSH WS TLS      : $wstls"
echo -e ""
echo -e " ${rd}1.)${NC}  Create Accounts SSH & OpenVPN"
echo -e " ${rd}2.)${NC}  Trial Accounts SSH & OpenVPN"
echo -e " ${rd}3.)${NC}  Renew Accounts SSH & OpenVPN"
echo -e " ${rd}4.)${NC}  Remove Accounts SSH & OpenVPN"
echo -e " ${rd}5.)${NC}  Check User Online SSH & OpenVPN"
echo -e " ${rd}6.)${NC}  List Accounts SSH & OpenVPN"
echo -e ""
echo -e " ${rd}7.)${NC}  Autokill User Multilogin"
echo -e " ${rd}8.)${NC}  View Log User Multilogin"
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e " Press enter to return to the menu"
echo -e ""
read -p "Select Of Number : " opt
echo -e ""
case $opt in
01 | 1) clear ; create ;;
02 | 2) clear ; trial ;;
03 | 3) clear ; renew ;;
04 | 4) clear ; hapus ;;
05 | 5) clear ; cek ;;
06 | 6) clear ; list ;;
07 | 7) clear ; kil ;;
08 | 8) clear ; limit ;;
*) clear ; menu ;;
esac
