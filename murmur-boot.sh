#! /bin/bash

#Murmur v1.02 network provision for Rasbian
#AM 11/24

#CONFIG Defaults (Please do not change here as it will get overwriten by a the config file)
#~/murmur.conf Ver 1.0
boot-type="wifi"
static-address="false"
wireless-channel="1"
wireless-essid="murmur"
mesh-mtu=""
source ~/murmur.conf

echo Config Values
echo $boot-type $static-address $wireless-channel $wireless-essid $mesh-mtu

 
#FUNCTIONS - - - - -

function provision-murmur {

echo Starting Murmur v1.0 network provision for Rasbian
echo
echo clearing old wireless config..
sudo rm /etc/network/interfaces.d/wlan0
sudo touch /etc/network/interfaces.d/wlan0
echo 
echo interfaces.d Config:
echo Writing...
echo 'auto wlan0' | sudo tee --append /etc/network/interfaces.d/wlan0
echo 'iface wlan0 inet manual' | sudo tee --append /etc/network/interfaces.d/wlan0
echo 'wireless-channel $wireless-channel' | sudo tee --append /etc/network/interfaces.d/wlan0
echo 'wireless-essid $wireless-essid' | sudo tee --append /etc/network/interfaces.d/wlan0
echo 'wireless-mode ad-hoc' | sudo tee --append /etc/network/interfaces.d/wlan0
echo Complete...

if [[ $static-address != "false" ]]; then
	echo Setting Static Address: $static-address
	sudo ifconfig bat0 $static-address
	fi


echo Stopping wpa services
sudo service wpa_supplicant stop

echo Starting boot...
sudo batctl if add wlan0
sudo ifconfig bat0 mtu $mesh-mtu
sudo ifconfig wlan0 up
sudo ifconfig bat0 up
echo Provison ended.
}

function revert-to-wireless {
echo Using basic wireless. 
sudo rm /etc/network/interfaces.d/wlan0
}


#SCRIPT
if [[$USEMURMUR = "y"]]; then
		provision-murmur
	else
		revert-to-wireless
	fi

sudo systemctl restart networking
