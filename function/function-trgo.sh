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

export NC='\033[0m'
export multi='\E[44;1;39m'
export cyan='\033[0;36m'
export or='\033[1;33m'
export yl='\e[32;1m'
export rd='\e[31;1m'
export C='\033[0;36m'
export R='\e[31;1m'

function create(){
clear
uuid=$(cat /etc/trojan-go/uuid.txt)
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
trgo="$(cat ~/log-install.txt | grep -w "Trojan-Go" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "
${or}===========================================${NC}
         ${yl}Please Input Password
        Or Exit Tap ( CTRL + C )${NC}
${or}===========================================${NC}"
echo ""
		read -rp "$( echo -e "${rd}=>${NC} ${C}Input Password :${NC} ")" -e user
		user_EXISTS=$(grep -w $user /etc/trojan-go/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
read -rp "$( echo -e "${rd}=>${NC} ${C}Input Expired :${NC} ")" -e masaaktif
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan-go/config.json
echo ""
echo -e "${C}Wait... Sett Up Accounts${NC}"
sleep 1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan-go/akun.conf
systemctl restart trojan-go.service
link="trojan://${user}@${domain}:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=/directpath&encryption=none#$user"
EOF
cat >/home/vps/public_html/trojanGO-$user.txt <<-END
====================================================================
                  AUTOSCRIPT INSTALLER XRAY-SSH
====================================================================
            Berikut dibawah ini adalah format OpenClash
====================================================================

- name: TrojanGO-TLS-$user
  server: ${domain}
  port: 2087
  type: trojan
  password: ${user}
  skip-cert-verify: true
  sni: ${domain}
  network: ws
  ws-opts:
    path: /directpath
    headers:
      Host: ${domain}
  udp: true

_______________________________________________________
                Link TrojanGo Account
_______________________________________________________
Link TrojanGO : ${link}
_______________________________________________________
END
clear
sleep 0.8
echo -e ""
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "  Trojan-GO Account"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Remarks    : ${user}"
echo -e "Domain     : ${domain}"
echo -e "Port       : ${trgo}"
echo -e "Password   : ${user}"
echo -e "Encryption : none"
echo -e "Path       : /directpath"
echo -e "Created    : $hariini"
echo -e "Expired    : $exp"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link Trojan-Go : ${link}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Format OpenClash :"
echo -e "${domain}:89/trojanGO-$user.txt"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-TrojanGO"
menu-trgo
}

function trial(){
clear
uuid=$(cat /etc/trojan-go/uuid.txt)
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
trgo="$(cat ~/log-install.txt | grep -w "Trojan-Go" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
		user_EXISTS=$(grep -w $user /etc/trojan-go/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
masaaktif="1"
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan-go/config.json
echo -e "${C}Wait... Sett Up Accounts${NC}"
sleep 1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan-go/akun.conf
systemctl restart trojan-go.service
link="trojan://${user}@${domain}:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=/directpath&encryption=none#$user"
EOF
cat >/home/vps/public_html/trojanGO-$user.txt <<-END
====================================================================
                  AUTOSCRIPT INSTALLER XRAY-SSH
====================================================================
            Berikut dibawah ini adalah format OpenClash
====================================================================

- name: TrojanGO-TLS-$user
  server: ${domain}
  port: 2087
  type: trojan
  password: ${user}
  skip-cert-verify: true
  sni: ${domain}
  network: ws
  ws-opts:
    path: /directpath
    headers:
      Host: ${domain}
  udp: true

_______________________________________________________
                Link TrojanGo Account
_______________________________________________________
Link TrojanGO : ${link}
_______________________________________________________
END
clear
sleep 0.8
echo -e ""
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "  Trojan-GO Account"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Remarks    : ${user}"
echo -e "Domain     : ${domain}"
echo -e "Port       : ${trgo}"
echo -e "Password   : ${user}"
echo -e "Encryption : none"
echo -e "Path       : /directpath"
echo -e "Created    : $hariini"
echo -e "Expired    : $exp"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link Trojan-Go : ${link}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Format OpenClash :"
echo -e "${domain}:89/trojanGO-$user.txt"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-TrojanGO"
menu-trgo
}

function renew(){
clear
echo "Error :("
}

function hapus(){
clear
echo "Error :("
}

function cek(){
clear
time=$(date "+%T")
echo ""
echo -n > /tmp/other.txt
data=( `cat /etc/trojan-go/akun.conf | grep '^###' | cut -d ' ' -f 2`);
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${multi}      ${rd}Trojan-Go User Login      ${NC}";
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrojango.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep trojan-go | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/trojan-go/trojan-go.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/iptrojango.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrojango.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/iptrojango.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/iptrojango.txt | nl)
echo "user : $akun";
echo "$jum2";
echo "------------------------------------";
fi
rm -rf /tmp/iptrojango.txt
done
oth=$(cat /tmp/other.txt | sort | uniq | nl)
echo -e "${or}Date Time      :${NC} ${time}";
echo -e "${or}List IP Online :${NC}";
echo -e "${rd}$oth${NC}";
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
rm -rf /tmp/other.txt
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-TrojanGO"
menu-trgo
}

clear
# // Status Trgo
ssh_ws=$( systemctl status trojan-go | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    trgo="${green}Running | Normal${NC}"
else
    trgo="${rd}Stopped | Error${NC}"
fi
echo ""
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e " ${multi}                    ${rd}TROJAN-GO MENU                   ${NC}"
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e "Trojan-Go : $trgo"
echo -e "
 ${rd}1.)${NC}  Create Accounts Trojan-Go
 ${rd}2.)${NC}  Trial Accounts Trojan-Go
 ${rd}3.)${NC}  Renew Accounts Trojan-Go
 ${rd}4.)${NC}  Remove Accounts Trojan-Go
 ${rd}5.)${NC}  Check User Online Trojan-Go"
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e "Press enter to return to the menu"
echo -e ""
read -p "Input Your Choose : " opt
echo -e ""
case $opt in
01 | 1) clear ; create ;;
02 | 2) clear ; trial ;;
03 | 3) clear ; renew ;;
04 | 4) clear ; hapus ;;
05 | 5) clear ; cek ;;
*) clear ; menu ;;
esac
