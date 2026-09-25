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
export cyan='\033[0;36m'
export or='\033[1;33m'
export yl='\e[32;1m'
export rd='\e[31;1m'
export C='\033[0;36m'
export R='\e[31;1m'

echo -e ""
function create(){
clear
domain=$(cat /etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "
${or}=======================================${NC}
        ${yl}Please Input Username
       Or Exit Tap ( CTRL + C )${NC}
${or}=======================================${NC}"
echo ""
		read -rp "$( echo -e "${rd}=>${NC} ${C}Input Username :${NC} ")" -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${CLIENT_NAME}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -rp "$( echo -e "${rd}=>${NC} ${C}Input Expired  :${NC} ")" -e masaaktif
echo ""
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
sed -i '/#xray-vmess-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
echo -e "${C}Wait... Sett Up Accounts${NC}"
sleep 1
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
cat>/etc/xray/vmess-$user-nontls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
xrayv2ray1="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
xrayv2ray2="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
rm -rf /etc/xray/vmess-$user-tls.json
rm -rf /etc/xray/vmess-$user-nontls.json
EOF
cat >/home/vps/public_html/vmess-$user.txt <<-END
====================================================================
                  AUTOSCRIPT INSTALLER XRAY-SSH
====================================================================
            Berikut dibawah ini adalah format OpenClash
====================================================================
_______________________________________________________
              Format Vmess WS (CDN) TLS
_______________________________________________________

- name: Vmess-TLS-$user
  type: vmess
  server: ${domain}
  port: 8443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /v2ray
    headers:
      Host: ${domain}
_______________________________________________________
              Format Vmess WS (CDN) Non TLS
_______________________________________________________

- name: Vmess-NoneTLS-$user
  type: vmess
  server: ${domain}
  port: 8880
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /v2ray
    headers:
      Host: ${domain}
_______________________________________________________
                Link Vmess Account
_______________________________________________________
Link TLS : ${xrayv2ray1}
_______________________________________________________
Link None TLS : ${xrayv2ray2}
_______________________________________________________
END
systemctl restart xray.service
service cron restart
clear
echo -e ""
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "    Xray/Vmess Account"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Remarks     : ${user}"
echo -e "Domain      : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port HTTP   : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws"
echo -e "Path        : /v2ray"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link TLS  : ${xrayv2ray1}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link HTTP : ${xrayv2ray2}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Format OpenClash :"
echo -e "${domain}:89/vmess-$user.txt"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function trial(){
clear
sleep 0.5
domain=$(cat /etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${CLIENT_NAME}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif="1"
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
sed -i '/#xray-vmess-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
echo -e "${C}Wait... Sett Up Accounts${NC}"
sleep 1
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
cat>/etc/xray/vmess-$user-nontls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
xrayv2ray1="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
xrayv2ray2="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
rm -rf /etc/xray/vmess-$user-tls.json
rm -rf /etc/xray/vmess-$user-nontls.json
EOF
cat >/home/vps/public_html/vmess-$user.txt <<-END
====================================================================
                  AUTOSCRIPT INSTALLER XRAY-SSH
====================================================================
            Berikut dibawah ini adalah format OpenClash
====================================================================
_______________________________________________________
              Format Vmess WS (CDN) TLS
_______________________________________________________

- name: Vmess-TLS-$user
  type: vmess
  server: ${domain}
  port: 8443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /v2ray
    headers:
      Host: ${domain}
_______________________________________________________
              Format Vmess WS (CDN) Non TLS
_______________________________________________________

- name: Vmess-NoneTLS-$user
  type: vmess
  server: ${domain}
  port: 8880
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /v2ray
    headers:
      Host: ${domain}
_______________________________________________________
                Link Vmess Account
_______________________________________________________
Link TLS : ${xrayv2ray1}
_______________________________________________________
Link None TLS : ${xrayv2ray2}
_______________________________________________________
END
systemctl restart xray.service
service cron restart
clear
echo -e ""
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "    Xray/Vmess Account"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Remarks     : ${user}"
echo -e "Domain      : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port HTTP   : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws"
echo -e "Path        : /v2ray"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link TLS  : ${xrayv2ray1}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link HTTP : ${xrayv2ray2}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Format OpenClash :"
echo -e "${domain}:89/vmess-$user.txt"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function renew(){
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "[${rd}NOTES${NC}] • You have no existing clients!"
echo ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
fi
clear
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${multi}     ${rd}Renew Accounts Xray-Vmess       ${NC}"
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | sort | uniq | nl
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "[${rd}NOTE${NC}] Tap Enter To Back Menu-Vmess"
echo ""
read -rp "Input Username : " user
if [ -z $user ]; then
menu-vmess
else
read -p "Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/### $user/c\### $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "--------------------------------------------------------------" | lolcat
echo -e "[${green}INFO${NC}] $user Account Renewed Successfully"
echo -e ""
echo -e "Username   : $user"
echo -e "Days Added : $masaaktif Days"
echo -e "Expired On : $exp4"
echo -e "--------------------------------------------------------------" | lolcat
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
fi
}

function hapus(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "[${rd}NOTES${NC}] • You Dont have any existing clients!"
echo ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
fi
clear
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${multi}     ${rd}Delete Accounts Xray-Vmess      ${NC}"
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | sort | uniq | nl
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "[${rd}NOTE${NC}] Tap Enter To Back Menu-Vmess"
echo -e ""
read -rp "Input Username : " user
if [ -z $user ]; then
menu-vmess
else
exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
rm -f /home/vps/public_html/vmess-$user.txt
systemctl restart xray > /dev/null 2>&1
clear
echo -e "------------------------------------------------------" | lolcat
echo -e "[${green}INFO${NC}] • Accound Delete Successfully"
echo -e ""
echo -e "Username   : $user"
echo -e "Expired On : $exp"
echo -e "------------------------------------------------------" | lolcat
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
fi
}

function cek(){
clear
time=$(date "+%T")
echo ""
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2`);
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
echo -e "${multi}        ${rd}Vmess User Login        ${NC}";
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}";
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipvmess.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep xray | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
echo "----------------------------------------"
fi
rm -rf /tmp/ipvmess.txt
done
oth=$(cat /tmp/other.txt | sort | uniq | nl)
echo -e "${or}Date Time      :${NC} ${time}";
echo -e "${or}List IP Online :${NC}";
echo -e "${rd}$oth${NC}";
echo -e "${cyan}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
rm -rf /tmp/other.txt
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function createvless(){
clear
domain=$(cat /etc/xray/domain)
tls="2087"
nontls="2082"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-vless-tls$/a\#&&# '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#xray-vless-nontls$/a\#&&# '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
xrayvless1="vless://${uuid}@${domain}:$tls?path=/vless-tls&security=tls&encryption=none&type=ws#${user}"
xrayvless2="vless://${uuid}@${domain}:$nontls?path=/vless-ntls&encryption=none&type=ws#${user}"
cat >/home/vps/public_html/vless-$user.txt <<-END
====================================================================
                  AUTOSCRIPT INSTALLER XRAY-SSH
====================================================================
            Berikut dibawah ini adalah format OpenClash
====================================================================
_______________________________________________________
              Format Vless WS (CDN) TLS
_______________________________________________________

- name: Vless-TLS-${user}
  server: ${domain}
  type: vless
  port: 2087
  uuid: ${uuid}
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless-tls
    headers:
      Host: ${domain}
  udp: true
_______________________________________________________
              Format Vless WS (CDN) Non TLS
_______________________________________________________

- name: Vless-NTLS-${user}
  server: ${domain}
  type: vless
  port: 2082
  uuid: ${uuid}
  tls: false
  network: ws
  ws-opts:
    path: /vless-ntls
    headers:
      Host: ${domain}
  udp: terus
_______________________________________________________
                Link Vless Account
_______________________________________________________
Link TLS : ${xrayvless1}
_______________________________________________________
Link None TLS : ${xrayvless2}
_______________________________________________________
END
systemctl restart xray.service
service cron restart
sleep 0.5
clear
echo -e ""
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "    Xray/Vless Account"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Remarks     : ${user}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : $tls"
echo -e "Port NTLS   : $nontls"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Network     : ws"
echo -e "Path NTLS   : /vless-ntls"
echo -e "Path TLS    : /gle ws-tls"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link TLS    : ${xrayvless1}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link NTLS : ${xrayvless2}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function trialvless(){
clear
domain=$(cat /etc/xray/domain)
tls="2087"
nontls="2082"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif="1"
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-vless-tls$/a\#&&# '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#xray-vless-nontls$/a\#&&# '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
xrayvless1="vless://${uuid}@${domain}:$tls?path=/vless-tls&security=tls&encryption=none&type=ws#${user}"
xrayvless2="vless://${uuid}@${domain}:$nontls?path=/vless-ntls&encryption=none&type=ws#${user}"
cat >/home/vps/public_html/vless-$user.txt <<-END
====================================================================
                  AUTOSCRIPT INSTALLER XRAY-SSH
====================================================================
            Berikut dibawah ini adalah format OpenClash
====================================================================
_______________________________________________________
              Format Vless WS (CDN) TLS
_______________________________________________________

- name: Vless-TLS-${user}
  server: ${domain}
  type: vless
  port: 2087
  uuid: ${uuid}
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless-tls
    headers:
      Host: ${domain}
  udp: true
_______________________________________________________
              Format Vless WS (CDN) Non TLS
_______________________________________________________

- name: Vless-NTLS-${user}
  server: ${domain}
  type: vless
  port: 2082
  uuid: ${uuid}
  tls: false
  network: ws
  ws-opts:
    path: /vless-ntls
    headers:
      Host: ${domain}
  udp: true
_______________________________________________________
                Link Vless Account
_______________________________________________________
Link TLS : ${xrayvless1}
_______________________________________________________
Link None TLS : ${xrayvless2}
_______________________________________________________
END
systemctl restart xray.service
service cron restart
sleep 0.5
clear
echo -e ""
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "    Xray/Vless Account"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Remarks     : ${user}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : $tls"
echo -e "Port NTLS   : $nontls"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Network     : ws"
echo -e "Path NTLS   : /vless-ntls"
echo -e "Path TLS    : /vless-tls"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link TLS    : ${xrayvless1}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Link NTLS : ${xrayvless2}"
echo -e "•━━━━━━━━━━━━━━━━━━━━━━•"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function renewvless(){
clear
grep -E "^#&&# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | sort | uniq | nl
echo ""
read -rp "Input Username : " user
read -p "Expired (days): " masaaktif
exp=$(grep -E "^#&&# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#&&# $user/c\#&&# $user $exp4" /etc/xray/config.json
sleep 0.5
systemctl restart xray
clear
echo -e "--------------------------------------------------------------" | lolcat
echo -e "$user Account Renewed Successfully"
echo -e ""
echo -e "Username   : $user"
echo -e "Days Added : $masaaktif Days"
echo -e "Expired On : $exp4"
echo -e "--------------------------------------------------------------" | lolcat
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function deletevless(){
clear
grep -E "^#&&# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | sort | uniq | nl
echo ""
read -rp "Input Username : " user
sleep 0.5
exp=$(grep -wE "^#&&# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#&&# $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray
echo -e "------------------------------------------------------" | lolcat
echo -e "Username   : $user"
echo -e "Expired On : $exp"
echo -e "------------------------------------------------------" | lolcat
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function addblocksite(){
clear
read -p "Enter domain for blocked : " domain
sleep 1
  if [[ -z "$domain" ]]; then
    echo -e "${rd}Error: Domain cannot be empty${NC}"
  elif grep -q "\"domain\": \[\"$domain\"\]" "/etc/xray/config.json"; then
    echo -e "${or}Domain '$domain' is already blocked.${NC}"
  else
    echo -e "${C}Adding domain '$domain' to be blocked...${NC}"
    sed -i "/\"rules\": \[/a \\\t{ \"type\": \"field\", \"domain\": [\"$domain\"], \"outboundTag\": \"blocked\" }," "etc/xray/config.json"
    echo -e "${C}Domain '$domain' added to be blocked.${NC}"
    systemctl restart xray
  fi
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function listblocked(){
clear
sleep 0.5
grep -oP '(?<=domain": \[")[^"]*' "/etc/xray/config.json" | nl -w2 -s". "
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

function unblocksite(){
clear
read -p "Enter domain to unblock : " index
sleep 1
  domain=$(grep -oP '(?<=domain": \[")[^"]*' "/etc/xray/config.json" | sed -n "${index}p")
  if [ -z "$domain" ]; then
    echo -e "${rd}Invalid selection.${NC}"
  else
    echo -e "Removing domain '$domain' from blocked list..."
    sed -i "/\"domain\": \[\"$domain\"\],/d" "/etc/xray/config.json"
    echo -e "${or}Domain '$domain' removed from blocked list${NC}"
    systemctl restart xray
  fi
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Menu-Vmess"
menu-vmess
}

clear
# // Status Nginx
ssh_ws=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    nx="${green}Running | Normal${NC}"
else
    nx="${rd}Stopped | Error${NC}"
fi

# // Status Xray
ssh_ws=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    xvm="${green}Running | Normal${NC}"
else
    xvm="${rd}Stopped | Error${NC}"
fi
echo ""
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e " ${multi}                ${rd}XRAY VMESS/VLESS MENU               ${NC}"
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e " XRAY VMESS : $xvm"
echo -e " XRAY VLESS : $xvm"
echo -e " NGINX      : $nx"
echo -e "
 ${rd}1.)${NC}  Create Accounts Xray/Vmess
 ${rd}2.)${NC}  Create Accounts Trial Xray/Vmess
 ${rd}3.)${NC}  Renew Accounts Xray/Vmess
 ${rd}4.)${NC}  Remove Accounts Xray/Vmess
 ${rd}5.)${NC}  Check User Online Xray/Vless

 ${rd}6.)${NC}  Create Accounts Xray/Vless
 ${rd}7.)${NC}  Create Trial Xray/Vless
 ${rd}8.)${NC}  Renew Accounts Xray/Vless
 ${rd}9.)${NC}  Remove Accounts Xray/Vless"
echo -e "${cyan}───────────────────────────────────────────────────────${NC}"
echo -e "Press enter to return to the menu"
echo -e ""
read -p "Select Of Number : " opt
echo -e ""
case $opt in
01 | 1) clear ; create ;;
02 | 2) clear ; trial ;;
03 | 3) clear ; renew ;;
04 | 4) clear ; hapus ;;
05 | 5) clear ; cek ;;
06 | 6) clear ; createvless ;;
07 | 7) clear ; trialvless ;;
08 | 8) clear ; renewvless ;;
09 | 9) clear ; deletevless ;;
10) clear ; addblocksite ;;
11) clear ; listblocked ;;
12) clear ; unblocksite ;;
*) clear ; menu ;;
esac
