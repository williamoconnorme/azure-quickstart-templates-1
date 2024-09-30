#!/bin/bash
userPassword=$1

#download the packages
cd /tmp
wget -c http://ftp.uk.debian.org/debian/pool/main/o/openvpn/openvpn_2.6.12-1_amd64.deb

#install the software
sudo dpkg -i openvpn-as-2.1.9-Ubuntu16.amd_64.deb

#update the password for user openvpn
sudo echo "openvpn:$userPassword"|sudo chpasswd

#configure server network settings
PUBLICIP=$(curl -s ifconfig.me)
sudo apt-get install sqlite3
sudo sqlite3 "/usr/local/openvpn_as/etc/db/config.db" "update config set value='$PUBLICIP' where name='host.name';"

#restart OpenVPN AS service
sudo systemctl restart openvpnas
