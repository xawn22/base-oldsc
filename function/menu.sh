#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
url1="app.servpanel.biz.id/function"
url2="app.servpanel.biz.id/dll"
url3="app.servpanel.biz.id/shell"
#color code
export NC='\033[0m'
export multi='\E[44;1;39m'
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
export light='\033[0;37m'
export W='\033[0;97m'
export end='\033[0m'
export all='\E[42;1;39m'

function status(){
#########################
# GETTING OS INFORMATION
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID

CITY=$( curl -s ipinfo.io/city )

# CHEK STATUS 
openvpn_service="$(systemctl show openvpn.service --no-page)"
oovpn=$(echo "${openvpn_service}" | grep 'ActiveState=' | cut -f2 -d=)
tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_server=$(systemctl status trojan-go | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel_service=$(/etc/init.d/stunnel5 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(/etc/init.d/squid status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wstls=$(systemctl status ws-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsdrop=$(systemctl status ws-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
shd=$(systemctl status sshd | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
udp=$(systemctl status rc-local | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsovpn=$(systemctl status ws-ovpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron=$(systemctl status cron | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sqd=$(systemctl status squid | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
udpsts=$(systemctl status udp-custom | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
shohp=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
opohp=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# COLOR VALIDATION
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
green='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
c='\033[0;36m'
LIGHT='\033[0;37m'
clear

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh="${GREEN}ON ( Running )${NC}"
else
   status_ssh="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat="${GREEN}ON ( Running )${NC}"
else
   status_vnstat="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban="${GREEN}ON ( Running )${NC}"
else
   status_fail2ban="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE  TLS 
if [[ $tls_v2ray_status == "running" ]]; then 
   v2ray_tls="${GREEN}ON ( Running )${NC}"
else
   v2ray_tls="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE NON TLS V2RAY
if [[ $nontls_v2ray_status == "running" ]]; then 
   v2ray_ntls="${GREEN}ON ( Running )${NC}"
else
   v2ray_ntls="${RED}OFF ( Error )${NC}"
fi

# Status Service Trojan GO
if [[ $strgo == "active" ]]; then
  status_trg="${GREEN}ON ( Running )${NC}"
else
  status_trg="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE L2TP
if [[ $trojan_server == "running" ]]; then 
   status_trgo="${GREEN}ON ( Running )${NC}"
else
   status_trgo="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh="${GREEN}ON ( Running )${NC}"
else
   status_beruangjatuh="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE STUNNEL
if [[ $stunnel_service == "running" ]]; then 
   status_stunnel="${GREEN}ON ( Running )${NC}"
else
   status_stunnel="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET TLS
if [[ $wstls == "running" ]]; then 
   swstls="${GREEN}ON ( Running )${NC}"
else
   swstls="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET DROPBEAR
if [[ $wsdrop == "running" ]]; then 
   swsdrop="${GREEN}ON ( Running )${NC}"
else
   swsdrop="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET OPEN OVPN
if [[ $wsovpn == "running" ]]; then 
   swsovpn="${GREEN}ON ( Running )${NC}"
else
   swsovpn="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE SSLH / SSH
if [[ $osslh == "running" ]]; then 
   sosslh="${GREEN}ON ( Running )${NC}"
else
   sosslh="${RED}OFF ( Error )${NC}"
fi

# STATUS OHP DROPBEAR
if [[ $ohp == "running" ]]; then 
   sohp="${GREEN}ON ( Running )${NC}"
else
   sohp="${RED}OFF ( Error )${NC}"
fi

# STATUS OHP OpenVPN
if [[ $ohq == "running" ]]; then 
   sohq="${GREEN}ON ( Running )${NC}"
else
   sohq="${RED}OFF ( Error )${NC}"
fi

# STATUS OHP SSH
if [[ $ohr == "running" ]]; then 
   sohr="${GREEN}ON ( Running )${NC}"
else
   sohr="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET OPENSSH
if [[ $wsopen == "running" ]]; then 
   swsopen="${GREEN}ON ( Running )${NC}" 
else
   swsopen="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE SSHD
if [[ $shd == "running" ]]; then 
   shdd="${GREEN}ON ( Running )${NC}" 
else
   shdd="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE BADVPN
if [[ $udp == "running" ]]; then 
   udpw="${GREEN}ON ( Running )${NC}" 
else
   udpw="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE CRON
if [[ $cron == "running" ]]; then 
   cr="${GREEN}ON ( Running )${NC}" 
else
   cr="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE SQUID
if [[ $sqd == "running" ]]; then 
   sq="${GREEN}ON ( Running )${NC}" 
else
   sq="${RED}OFF ( Error )${NC}"
fi

# STATUS SERVICE NGINX
if [[ $nginx == "running" ]]; then 
   nx="${GREEN}ON ( Running )${NC}" 
else
   nx="${RED}OFF ( Error )${NC}"
fi
clear

# STATUS UDP CUSTOM
if [[ ${udpsts} == "running" ]]; then
   udp="${GREEN}ON ( Running )${NC}"
else
   udp="${RED}OFF ( Error )${NC}"
fi

# STATUS SSH OHP
if [[ ${shohp} == "running" ]]; then
   ssh_ohp="${GREEN}ON ( Running )${NC}"
else
   ssh_ohp="${RED}OFF ( Error )${NC}"
fi

# STATUS DROPBEAR OHP
if [[ ${dropohp} == "running" ]]; then
   dropbear_ohp="${GREEN}ON ( Running )${NC}"
else
   dropbear_ohp="${RED}OFF ( Error )${NC}"
fi

# STATUS OPENVPN OHP
if [[ ${opohp} == "running" ]]; then
   openvpn_ohp="${GREEN}ON ( Running )${NC}"
else
   openvpn_ohp="${RED}OFF ( Error )${NC}"
fi

echo -e ""
clear
loadcpu=$(printf '%-0.00001s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
up="$(uptime -p | cut -d " " -f 2-10)"
cpu=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
core=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
ct=$(curl -s ipinfo.io/city )
sp=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
IPVPS=$(curl -s ipinfo.io/ip )
DOMAIN=$(cat /etc/xray/domain)
echo -e ""
echo -e " ${ORANGE}DOMAIN      = $DOMAIN"
echo -e " IP          = $IPVPS"
echo -e " ISP         = $sp"
echo -e " CITY        = $ct"
echo -e " LOAD CPU    = $loadcpu %"
echo -e " OS NAME     = "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e " CORE        = $core"
echo -e " UPTIME      = $up"
echo -e " CPU MODEL   =$cpu"
echo -e " RAM         = $tram MB / $uram MB"
echo -e " STORAGE     = $(df -h / | awk '{print $2}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB" " / Usage $(df -h / | awk '{print $3}' | tail -n1 | sed 's/G//g' | sed 's/ //g') GB${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${multi}                ${rd}Status All Service                  ${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${green}•${NC} NGINX                        = $nx !"
echo -e " ${green}•${NC} SSH / TUN                    = $status_ssh !"
echo -e " ${green}•${NC} OVPN WS                      = $swsovpn !"
echo -e " ${green}•${NC} DROPBEAR                     = $status_beruangjatuh !"
echo -e " ${green}•${NC} VNSTAT                       = $status_vnstat !"
echo -e " ${green}•${NC} SSH WS TLS                   = $swstls !"
echo -e " ${green}•${NC} SSH WS NONE TLS              = $swsdrop !"
echo -e " ${green}•${NC} VMESS TLS                    = $v2ray_tls !"
echo -e " ${green}•${NC} TROJAN GO TLS                = $status_trgo !"
echo -e " ${green}•${NC} STUNNEL                      = $status_stunnel !"
echo -e " ${green}•${NC} SSLH                         = $sosslh !"
echo -e " ${green}•${NC} FAIL2BAN                     = $status_fail2ban !"
echo -e " ${green}•${NC} SSHD                         = $shdd !"
echo -e " ${green}•${NC} BADVPN UDPGW                 = $udpw !"
echo -e " ${green}•${NC} CRONTAB                      = $cr !"
echo -e " ${green}•${NC} SQUID PROXY                  = $sq !"
echo -e " ${green}•${NC} SSH UDP                      = ${udp} !"
echo -e " ${green}•${NC} DROPBEAR OHP                 = ${dropbear_ohp} !"
echo -e " ${green}•${NC} OPENVPN OHP                  = ${openvpn_ohp} !"
echo -e " ${green}•${NC} SSH OHP                      = ${ssh_ohp} !"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Home-Menu"
menu
}

function update(){
clear
echo -e "------------------------------------------------------" | lolcat
echo -e "  ${W}Please wait processing update autoscript xray-ssh${NC}"
echo -e "------------------------------------------------------" | lolcat
sleep 1
wget -q -O /usr/bin/autobckpbot "https://${url2}/bckp.sh" && chmod +x /usr/bin/autobckpbot
wget -q -O /usr/bin/cf-pointing "https://${url1}/cloudflare-pointing.sh" && chmod +x /usr/bin/cf-pointing
wget -q -O /usr/bin/aubckp "https://${url2}/autobckp.sh" && chmod +x /usr/bin/aubckp
wget -q -O /usr/bin/cf-setting "https://${url1}/cloudflare-setting.sh" && chmod +x /usr/bin/cf-setting
wget -q -O /usr/bin/menu "https://${url1}/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/menu-ssh "https://${url1}/function-ssh.sh" && chmod +x /usr/bin/menu-ssh
wget -q -O /usr/bin/menu-vmess "https://${url1}/function-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/menu-trgo "https://${url1}/function-trgo.sh" && chmod +x /usr/bin/menu-trgo
wget -q -O /usr/bin/license "https://${url1}/license.sh" && chmod +x /usr/bin/license
wget -q -O /usr/bin/backup "https://${url2}/gdrive.sh" && chmod +x /usr/bin/backup
wget -q -O /usr/bin/bkp "https://${url2}/autobackup.sh" && chmod +x /usr/bin/bkp
wget -q -O /usr/bin/info "https://${url3}/info.sh" && chmod +x /usr/bin/info
wget -q -O /usr/bin/exp "https://${url3}/autoremove.sh" && chmod +x /usr/bin/exp
wget -q -O /usr/bin/wbmn "https://${url3}/webmin.sh" && chmod +x /usr/bin/wbmn
wget -q -O /usr/bin/limit "https://${url1}/limit.sh" && chmod +x /usr/bin/limit
wget -q -O /usr/bin/monitorbw "https://${url1}/monitoring.sh" && chmod +x /usr/bin/monitorbw
wget -q -O /usr/bin/autobckp "https://${url2}/backup2024.sh" && chmod +x /usr/bin/autobckp
wget -q -O /usr/bin/autov2 "https://${url2}/autobckp_v2.sh" && chmod +x /usr/bin/autov2
sleep 2
echo -e "${or}Update AutoScript X22-SCRIPT Succesfuly${NC}"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Home-Menu"
menu
}

function about(){
clear
echo -e " Saya Berkarya Sesuai Kemampuan Saya Sendiri :)"
echo -e " Maafkan Saya Jika Saya Salah Dalam Menulis Kata²"
echo -e "================================================="
echo -e "#        AutoScript Installer XRAY-SSH          #"
echo -e "================================================="
echo -e "# For Debian 10 64 bit                          #"
echo -e "# For Ubuntu 18.04 & Ubuntu 20.04 64 bit        #"
echo -e "# For VPS with KVM and VMWare virtualization    #"
echo -e "# Modded And Update By Sikecil_Waan :D          #"
echo -e "================================================="
echo -e "# Thanks To                                     #"
echo -e "================================================="
echo -e "# Allah SWT                                     #"
echo -e "# My Family                                     #"
echo -e "# Horasss                                       #"
echo -e "================================================="
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Home-Menu"
menu
}

function changesub(){
clear
MYIP=$(wget -qO- ipinfo.io/ip);
clear
read -rp "Input New Domain : " -e domain
echo "$domain" > /var/lib/myscript/ipvps.conf
rm -rf /etc/xray/domain
echo "$domain" >/etc/xray/domain
echo -e "[ ${yl}INFO${NC} ] Start " 
sleep 0.5
systemctl stop ws-nontls
systemctl stop nginx
domain=$(cat /var/lib/myscript/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${rd}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${yl}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${yl}INFO${NC} ] Starting renew cert... " 
sleep 2
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --force --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${yl}INFO${NC} ] Renew cert done... " 
sleep 2
echo -e "[ ${yl}INFO${NC} ] Starting service $Cek " 
sleep 2
echo "$domain" >/etc/xray/domain
systemctl restart $Cek
systemctl restart nginx
echo -e "[ ${yl}INFO${NC} ] All finished... " 
sleep 0.5
clear
echo -e ""
echo -e "Starting Restart All Service"
sleep 2
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart xray
systemctl restart ws-ovpn
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
echo -e "Restart All Service Berhasil"
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Home-Menu"
menu
}

function certscript(){
clear
echo -e "${rd}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$nc"
echo -e "${yl}               • RENEW DOMAIN SSL •               $nc"
echo -e "${rd}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$nc"
echo -e ""
echo -e "[ ${yl}INFO${NC} ] Start " 
sleep 0.5
systemctl stop ws-nontls
systemctl stop nginx
domain=$(cat /var/lib/myscript/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${rd}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${yl}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${yl}INFO${NC} ] Starting renew cert... " 
sleep 2
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --force --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${yl}INFO${NC} ] Renew cert done... " 
sleep 2
echo -e "[ ${yl}INFO${NC} ] Starting service $Cek " 
sleep 2
echo "$domain" > /etc/xray/domain
systemctl restart $Cek
systemctl restart nginx
echo -e "[ ${yl}INFO${NC} ] All finished... " 
sleep 0.5
echo -e ""
read -n 1 -s -r -p "Tap Enter To Back Home-Menu"
menu
}

function restart(){
clear
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33m\033[1;37m- \033[0;33m["
    while true; do
        for ((i = 0; i < 8; i++)); do
            echo -ne "\033[0;32m🟣"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[0;33m\033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}
res1() {
    systemctl daemon-reload
}
res2() {
    systemctl restart nginx.service
}
res3() {
    systemctl restart xray.service
}
res4() {
    systemctl restart rc-local.service
}
res5() {
    systemctl restart dropbear.service
}
res6() {
    systemctl restart stunnel5.service
}
res7() {
    systemctl restart sshd.service
}
res8() {
    systemctl restart sslh.service
}
res9() {
    systemctl restart openvpn.service
}
res10() {
    systemctl restart cron.service
}
res11() {
    systemctl restart trojan-go.service
}
res12() {
    systemctl restart ws-tls.service
}
res13() {
    systemctl restart ws-nontls.service
}
res14() {
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
}

res15() {
systemctl restart udp-custom.service
}

res16() {
systemctl restart fail2ban.service
}

res17() {
systemctl restart squid.service
}


clear
echo -e "\e[31;1m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\E[47;1;39m       RESTART SERVICE YOU SERVER         \e[0m"
  echo -e "\e[31;1m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "  \033[1;33m Service Daemon-Reload\033[1;37m"
fun_bar 'res1'
echo -e "  \033[1;33m Service Restart Nginx\033[1;37m"
fun_bar 'res2'
echo -e "  \033[1;33m Service Restart Xray\033[1;37m"
fun_bar 'res3'
echo -e "  \033[1;33m Service Restart Rc-Local\033[1;37m"
fun_bar 'res4'
echo -e "  \033[1;33m Service Restart Dropbear\033[1;37m"
fun_bar 'res5'
echo -e "  \033[1;33m Service Restart Stunnel5\033[1;37m"
fun_bar 'res6'
echo -e "  \033[1;33m Service Restart Sshd\033[1;37m"
fun_bar 'res7'
echo -e "  \033[1;33m Service Restart Sslh\033[1;37m"
fun_bar 'res8'
echo -e "  \033[1;33m Service Restart OpenVpn\033[1;37m"
fun_bar 'res9'
echo -e "  \033[1;33m Service Restart Cron\033[1;37m"
fun_bar 'res10'
echo -e "  \033[1;33m Service Restart Trojan-Go\033[1;37m"
fun_bar 'res11'
echo -e "  \033[1;33m Service Restart Ws-TLS\033[1;37m"
fun_bar 'res12'
echo -e "  \033[1;33m Service Restart Ws-NonTLS\033[1;37m"
fun_bar 'res13'
echo -e "  \033[1;33m Service Restart Ssh-UDP\033[1;37m"
fun_bar 'res14'
echo -e "  \033[1;33m Service Restart Fail2ban\033[1;37m"
fun_bar 'res15'
echo -e "  \033[1;33m Service Restart Squid-Proxy\033[1;37m"
fun_bar 'res16'
  echo -e "\e[31;1m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -n 1 -s -r -p "Tap ( Enter ) to back menu.!!"
menu
}

function xol(){
clear
domainku=$(cat /etc/xray/domain)
echo -e "
Setup bot panel based by @XolPanel
Moodedd and update by @WaanSuka_Turu
Thanks All
" | lolcat
echo ""
read -rp "Tap enter to run install bot panel"
clear
read -p "Input Bot Token In Here : " botapi
sleep 0.2
read -p "Input Your Username Telegram : " user
sleep 0.2
read -p "Input User Id In Here : " idapi
sleep 0.3
cat > /media/cybervpn/var.txt << END
ADMIN="$idapi"
BOT_TOKEN="$botapi"
DOMAIN="$domainku"
DNS="example.a"
PUB="7fbd1f8aa0abfe15a7903e837f78aba39cf61d36f183bd604daa2fe4ef3b7b59"
OWN="$user"
SALDO="9999999"
END
systemctl restart cihuy
clear
echo -e "Setup Completed, type /menu in your bot" | lolcat
}

function blocksite(){
clear
kubali="\033[38;2;0;128;0m"
GREEN="\033[0;32m"
kataa="\033[31;1m"
siani="\033[0;36m"
mwisho="\033[0m"
teal_color="\033[38;2;100;182;172m"
orange="\033[0;33m"
PURPLE='\033[0;35m'
kidude="[+]"
kubali_kidude="${kubali}${kidude}${mwisho}"
kataa_kidude="${kataa}${kidude}"
dark_blue="\033[38;2;0;0;128m"
orange_kidude="${orange}\033[1m[!]$mwisho"

# Xray Configuration File
CONFIG_FILE="/etc/xray/config.json"
colors=(
  "\033[0;31m"  # Red
  "\033[0;32m"  # Green
  "\033[0;33m"  # Yellow
  "\033[0;34m"  # Blue
  "\033[0;35m"  # Purple
  "\033[0;36m"  # Cyan
  "\033[0;91m"  # Light Red
  "\033[0;92m"  # Light Green
  "\033[0;93m"  # Light Yellow
  "\033[0;94m"  # Light Blue
  "\033[0;95m"  # Light Purple
  "\033[0;96m"  # Light Cyan
)

# Function to choose a random color
function choose_random_color() {
  local num_colors=${#colors[@]}
  local random_index=$((RANDOM % num_colors))
  echo -e "${colors[random_index]}"
}
selected_color=$(choose_random_color)

function banner(){
  echo -e "${selected_color}
 BLOCK SITE ( VMESS & VLESS ONLY )
  ${mwisho}
  "
}
# Function to add a domain to be blocked
add_blocked_domain() {
  domain=$1
  if [[ -z "$domain" ]]; then
    echo -e "${kataa}Error: Domain cannot be empty.${mwisho}"
  elif grep -q "\"domain\": \[\"$domain\"\]" "$CONFIG_FILE"; then
    echo -e "${kataa}Domain '$domain' is already blocked.${mwisho}"
  else
    echo -e "${kubali}Adding domain '$domain' to be blocked...${mwisho}"
    sed -i "/\"rules\": \[/a \\\t{ \"type\": \"field\", \"domain\": [\"$domain\"], \"outboundTag\": \"blocked\" }," "$CONFIG_FILE"
    echo -e "${kubali}Domain '$domain' added to be blocked.${mwisho}"
    systemctl restart xray
  fi
}

# Function to list blocked domains
list_blocked_domains() {
  clear
  echo -e "${kubali_kidude}Blocked Domains:${mwisho}"
  echo -e "${light}========================${NC}"
  grep -oP '(?<=domain": \[")[^"]*' "$CONFIG_FILE" | nl -w2 -s". "
  echo -e "${light}========================${NC}"
}

# Function to remove a blocked domain
remove_blocked_domain() {
  index=$1
  domain=$(grep -oP '(?<=domain": \[")[^"]*' "$CONFIG_FILE" | sed -n "${index}p")
  if [ -z "$domain" ]; then
    echo -e "${kataa}Invalid selection.${mwisho}"
  else
    echo -e "Removing domain '$domain' from blocked list..."
    sed -i "/\"domain\": \[\"$domain\"\],/d" "$CONFIG_FILE"
    echo -e "${kubali_kidude}Domain '$domain' removed from blocked list."
    systemctl restart xray
  fi
}

# Main function
main() {
  while true; do
    clear
    banner
    echo -e "[${O}1${NC}]. ${light}Add a domain to be blocked${NC}"
    echo -e "[${O}2${NC}]. ${light}List blocked domains${NC}"
    echo -e "[${O}3${NC}]. ${light}Remove a domain from blocked list${NC}"
    echo -e "[${O}4${NC}]. ${rd}Exit${NC}"
echo ""
    read -p "Choose an option (1-4): " choice

    case $choice in
      1)
        read -p "$( echo -e "[${rd}!${NC}]")Enter domain to be blocked (e.g.example.com): " domain
        add_blocked_domain "$domain"
        read -rp "press any key to continue"
        ;;
      2)
        list_blocked_domains
        read -rp "press any key to continue"
        ;;
      3)
        list_blocked_domains
        read -p "$( echo -e "[${rd}!${NC}]")Enter number: " index
        remove_blocked_domain "$index"
        read -rp "press any key to continue"
        ;;
      4)
        echo -e "${rd}Exiting...${NC}"
        break
        ;;
      *)
        echo -e "${kataa}Invalid choice. Please try again${mwisho}."
        ;;
    esac

    echo
  done
}

main

}

function feature(){
clear
echo -e "
           ${C}┌─────────────────────────────────────────────┐${NC}
           ${C}│${NC}${new}            OTHER FEATURE SCRIPT             ${end}${C}│${NC}
           ${C}└─────────────────────────────────────────────┘${NC}
                    ${rd}1.)${NC} ${light}CHANGE MY SUBDOMAIN${NC}
                    ${rd}2.)${NC} ${light}BANDWITH MONITORING${NC}
                    ${rd}3.)${NC} ${light}RENEW CERT SSL${NC}
                    ${rd}4.)${NC} ${light}INSTALL WEBMIN${NC}
                    ${rd}5.)${NC} ${light}UPDATE X22-SCRIPT${NC}
                    ${rd}6.)${NC} ${light}PORT INFORMATION${NC}
                    ${rd}7.)${NC} ${light}LIMIT SPEED SERVER${NC}
                    ${rd}8.)${NC} ${light}INSTALL BOT PANEL${NC}
                    ${rd}9.)${NC} ${light}BLOCK SITE XRAY ONLY${NC}
                   ${rd}10.)${NC} ${light}STATUS SERVICE${NC}

                    ${rd}x.)${NC} ${rd}Enter To Back Menu${NC}
           ${C}──────────────────────────────────────────────${NC}"
                echo ""
                read -p "Chosse Input : " z
case $z in
1)
clear
changesub
;;
2)
clear
monitorbw
;;
3)
clear
certscript
;;
4)
clear
wbmn
;;
5)
clear
update
;;
6)
clear
info
;;
7)
clear
limit
;;
8)
clear
xol
;;
9)
clear
blocksite
;;
10)
status
;;
*)
menu
;;
esac
}

function backuptelebot(){
clear
if [ -f "/etc/token/token.json" ]; then
IP=$(curl -sS ipv4.icanhazip.com);
date=$(date +"%Y-%m-%d")
source /etc/token/token.json
mkdir -p /root/backup
cp -r /root/.acme.sh /root/backup/ &> /dev/null
cp -r /etc/xray /root/backup/xray/ &> /dev/null
cp -r /etc/trojan-go /root/backup/trojan-go/ &> /dev/null
cp -r /etc/passwd /root/backup/ &> /dev/null
cp -r /etc/group /root/backup/ &> /dev/null
cp -r /etc/shadow /root/backup/ &> /dev/null
cp -r /etc/gshadow /root/backup/ &> /dev/null
cp -r /etc/ppp/chap-secrets /root/backup/chap-secrets &> /dev/null
cp -r /var/lib/myscript/ /root/backup/myscript &> /dev/null
cp -r /etc/nginx/conf.d /root/backup/conf.d/ &> /dev/null
cp -r /home/vps/public_html /root/backup/public_html &> /dev/null
cp -r /etc/cron.d /root/backup/cron.d &> /dev/null
cp -r /etc/crontab /root/backup/crontab &> /dev/null
cp -r /etc/issue.net /root/backup/issue.net &> /dev/null
cp -r /media/cybervpn/database.db /root/backup/database.db &> /dev/null
cp -r /media/cybervpn/var.txt /root/backup/var.txt &> /dev/null
cd /root
zip -r $date.zip backup > /dev/null 2>&1
curl -F chat_id="${ID}" -F document=@"$date.zip" -F caption="
IP : $IP
Thank You" https://api.telegram.org/bot${TOKEN}/sendDocument &> /dev/null
cd /root
rm -rf /root/backup
rm -rf /root/$date.zip
echo -e "
0 * * * * root autobckp
" >/etc/cron.d/autobackup
systemctl restart cron
clear
echo -e "Auto Backup Data Every 1 Hours" | lolcat
echo ""
read -rp "Press any key to continue"
funbackup
exit 0
fi
echo -e "Database Not Found" | lolcat
}
function setdb(){
clear
source /etc/mydb.conf &> /dev/null
if [ -f "/etc/mydb.conf" ]; then
clear
echo -e "      THIS IS YOUR DATABASE" | lolcat
echo -e "         DATABASE FOUND" | lolcat
echo ""
echo -e " ${rd}BOT TOKEN:${NC} ${light}$token${NC}"
echo -e " ${rd}USER ID:${NC} ${light}$id${NC}"
echo ""
read -rp "Press any key to continue"
funbackup
exit 0
fi
echo -e "      SETT UP YOUR DATABASE" | lolcat
echo ""
read -p "  Input Bot Token: " a
sleep 0.3
read -p "  Input User ID  : " b
sleep 0.2
echo -e "
TOKEN="${a}"
ID="${b}"
" >/etc/token/token.json
echo -e "Sett Up Database Successsfully" | lolcat
echo ""
read -rp "Press any key to continue"
funbackup
}

function resbysftp(){
clear
cd
unzip *.zip
sleep 0.5
cp -r backup/passwd /etc/ &> /dev/null
cp -r backup/group /etc/ &> /dev/null
cp -r backup/shadow /etc/ &> /dev/null
cp -r backup/gshadow /etc/ &> /dev/null
cp -r backup/chap-secrets /etc/ppp/ &> /dev/null
cp -r backup/passwd1 /etc/ipsec.d/passwd &> /dev/null
cp -r backup/xray /etc/ &> /dev/null
cp -r backup/show /etc/ &> /dev/null
cp -r backup/trojan-go /etc/ &> /dev/null
cp -r backup/myscript /var/lib/ &> /dev/null
cp -r backup/.acme.sh /root/ &> /dev/null
cp -r backup/conf.d /etc/nginx/ &> /dev/null
cp -r backup/public_html /home/vps/ &> /dev/null
cp -r backup/crontab /etc/ &> /dev/null
cp -r backup/issue.net /etc/ &> /dev/null
cp -r backup/cron.d /etc/ &> /dev/null
cp -r backup/database.db /media/cybervpn/database.db &> /dev/null
cp -r backup/var.txt /media/cybervpn/var.txt &> /dev/null
sleep 0.5
systemctl restart cihuy
rm -rf *.zip
sleep 0.5
echo -e "Data Succesfully Restored" | lolcat
}

function newbckp(){
clear
rm -rf /etc/token
mkdir -p /etc/token/
read -p "Input Bot Token : " botztoken
sleep 0.5
read -p "Inpur User ID : " idnya
sleep 0.5
cat > /etc/token/token.json << END
TOKEN="${botztoken}"
ID="${idnya}"
END
echo -e "Succesfully" | lolcat
}
function funbackup(){
clear
echo -e "   BACKUP & RESTORE DATA SERVER" | lolcat
echo ""
echo -e " [${rd}1${NC}] - ${light}Auto Backup From Bot Telegram${NC}"
echo -e " [${rd}2${NC}] - ${light}Restore Data From SFTP${NC}"
echo -e " [${rd}3${NC}] - ${light}Sett Up Database${NC}"
echo -e " [${rd}4${NC}] - ${light}Sett Backup New${NC}"
echo -e " [${rd}*${NC}] - ${rd}Enter To Exit${NC}"
echo ""
read -p " Select Option : " o
case $o in
1)
backuptelebot
;;
2)
resbysftp
;;
3)
setdb
;;
4)
newbckp
;;
*)
menu
;;
esac
}
clear
script_info=$(curl -sS https://authku.servpanel.biz.id/message/notif-before.txt)
totalram=$(free -m | awk 'NR==2 {print $2}')
usageram=$(free -m | awk 'NR==2 {print $3}')
ip=$(curl -sS ipv4.icanhazip.com)
valid=$(curl -sS https://authku.servpanel.biz.id/check/database.ip | grep $ip | awk '{print $3}')
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
client=$(curl -sS https://authku.servpanel.biz.id/check/database.ip | grep $ip | awk '{print $2}')
datainfo=$(date)
upusage="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
tousage="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
downusage="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
trojanws=$(grep -E "^### " "/etc/trojan-go/akun.conf" | cut -d ' ' -f 2-3 | sort | uniq | wc -l)
sshws=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)
vmess=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | sort | uniq | wc -l)
vless=$(grep -E "^#&&# " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | sort | uniq | wc -l)
echo -e "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " ${C}│${NC}                   ${yl}Wellcome To X22-SCRIPT${NC}                   ${C}│${NC}
 ${C}│${NC}            ${yl}Thanks You For Using This AutoScript${NC}            ${C}│${NC}
 ${C}│${NC}                  ${rd}Script credit by @Horass${NC}                  ${C}│${NC}
 ${C}│${NC}                     ${rd}Modded by @Awn22${NC}                       ${C}│${NC}"
echo -e "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e "                 ${C}┌───────────────────────────┐${NC}
                 ${C}│${NC}${new} ☟☟ FOR MENU AUTOSCRIPT ☟☟ ${end}${C}│${NC}
                 ${C}└───────────────────────────┘${NC}
  ${C}┌───────────────────────────────────────────────────────────┐${NC}
  ${C}│${NC}    ${rd}1.) => ${NC} ${O}MENU SSH-WS${NC}         ${rd}5.) => ${NC} ${O}RESTART SERVICE${NC}    ${C}│${NC}
  ${C}│${NC}    ${rd}2.) => ${NC} ${O}MENU VMESS-WS${NC}       ${rd}6.) => ${NC} ${O}ABOUT X22-SCRIPT${NC}   ${C}│${NC}
  ${C}│${NC}    ${rd}3.) => ${NC} ${O}MENU TROJAN-WS${NC}      ${rd}7.) => ${NC} ${O}REBOOT SERVER${NC}      ${C}│${NC}
  ${C}│${NC}    ${rd}4.) => ${NC} ${O}BACKUP/RESTORE${NC}      ${rd}8.) => ${NC} ${O}OTHER FEATURE${NC}      ${C}│${NC}
  ${C}└───────────────────────────────────────────────────────────┘${NC}
  ${C}┌──────────────────────────────────────────┐${NC}
  ${C}│${NC}   ${O}• INFO •${NC}
  ${C}│${NC}   ${yl}Client Name :${NC} $client | Registered
  ${C}│${NC}   ${yl}Expry In    :${NC} $(((d1 - d2) / 86400)) Day | $valid
  ${C}│${NC}
  ${C}│${NC}   ${O}• INFO •${NC}
  ${C}│${NC}   ${yl}SSH-WS      :${NC} $sshws Account
  ${C}│${NC}   ${yl}VLESS-WS    :${NC} $vless Account
  ${C}│${NC}   ${yl}TROJAN-WS   :${NC} $trojanws Account
  ${C}│${NC}   ${yl}VMESS-WS    :${NC} $vmess Account
  ${C}└──────────────────────────────────────────┘${NC}"
echo -e "
 ${rd}NOTIF:${NC}
  ${light}${script_info}${NC}
"
read -p " Select Options Number ($( echo -e "${O}1-8${NC})") : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh;;
2) clear ; menu-vmess;;
3) clear ; menu-trgo;;
4) clear ; funbackup;;
5) clear ; restart;;
6) clear ; about;;
7) clear ; reboot;;
8) clear ; feature;;
*) echo -e "${rd}Failed Choice${NC}";;
esac
