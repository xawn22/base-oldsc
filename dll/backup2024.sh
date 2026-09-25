#!/bin/bash
clear
mydomain=$(cat /etc/xray/domain)
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
$(date)" https://api.telegram.org/bot${TOKEN}/sendDocument &> /dev/null
cd /root
rm -rf /root/backup
rm -rf /root/$date.zip
