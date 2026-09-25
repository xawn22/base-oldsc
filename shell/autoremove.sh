#!/bin/bash
source /media/cybervpn/var.txt
TIME="10"
URL="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"
#Autoremove expired accounts for Xray Vless
data=( `cat /etc/xray/config.json | grep '^#&&#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#&&# $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^#&&# $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^#&&# $user $exp/,/^},{/d" /etc/xray/config.json
LogVless="
<b>⚠️User Vless Expired⚠️</b>
━━━━━━━━━━━━━━━━━━━━━
<i>Host : ${DOMAIN}</i>
<i>User : $user</i>
<i>Exp  : $exp</i>
━━━━━━━━━━━━━━━━━━━━━
<b>Thank You For Order</b>
"
curl -s --max-time ${TIME} -d "chat_id=${ADMIN}&disable_web_page_preview=1&text=$LogVless&parse_mode=html" ${URL} >/dev/null
rm -f /etc/xray/$user-tls.json /etc/xray/$user-none.json
rm -f /home/vps/public_html/vless-$user.txt
fi
done
systemctl restart xray
systemctl restart nginx

#Autoremove expired accounts for Xray Vmess
data=( `cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
LogVmess="
<b>⚠️User Vmess Expired⚠️</b>
━━━━━━━━━━━━━━━━━━━━━
<i>Host : ${DOMAIN}</i>
<i>User : $user</i>
<i>Exp  : $exp</i>
━━━━━━━━━━━━━━━━━━━━━
<b>Thank You For Order</b>
"
curl -s --max-time ${TIME} -d "chat_id=${ADMIN}&disable_web_page_preview=1&text=$LogVmess&parse_mode=html" ${URL} >/dev/null
rm -f /etc/xray/$user-tls.json /etc/xray/$user-none.json
rm -f /home/vps/public_html/vmess-$user.txt
fi
done
systemctl restart xray
systemctl restart nginx

#Autoremove expired accounts for Trojan Go
data=( `cat /etc/trojan-go/akun.conf | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/trojan-go/akun.conf" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d" /etc/trojan-go/akun.conf
sed -i '/^,"'"$user"'"$/d' /etc/trojan-go/config.json
LogTrojanGo="
<b>⚠️User TrojanGo Expired⚠️</b>
━━━━━━━━━━━━━━━━━━━━━
<i>Host : ${DOMAIN}</i>
<i>User : $user</i>
<i>Exp  : $exp</i>
━━━━━━━━━━━━━━━━━━━━━
<b>Thank You For Order</b>
"
curl -s --max-time ${TIME} -d "chat_id=${ADMIN}&disable_web_page_preview=1&text=$LogTrojanGo&parse_mode=html" ${URL} >/dev/null
rm -f /home/vps/public_html/trojanGO-$user.txt
fi
done
systemctl restart trojan-go
systemctl restart nginx

#Autoremove expired accounts for ssh
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
               userdel $username
LogSsh="
<b>⚠️User Ssh Expired⚠️</b>
━━━━━━━━━━━━━━━━━━━━━
<i>Host : ${DOMAIN}</i>
<i>User : $username</i>
<i>Exp  : $tgl $bulantahun</i>
━━━━━━━━━━━━━━━━━━━━━
<b>Thank You For Order</b>
"
curl -s --max-time ${TIME} -d "chat_id=${ADMIN}&disable_web_page_preview=1&text=$LogSsh&parse_mode=html" ${URL} >/dev/null
               fi
               done
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart dropbear
systemctl restart stunnel5