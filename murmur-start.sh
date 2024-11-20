#! /bin/bash

#Murmur v1.03 network provision for Rasbian
#AM 11/24

#Log to Murmur.log
exec >> /home/keppler/murmur/murmur.log 2>&1

#CONFIG Defaults (Please do not change here as it will get overwriten by a the config file)
#~/murmur.conf Ver 1.0
BOOT_TYPE="wifi"
STATIC_ADDRESS="false"
WIRELESS_CHANNEL="1"
WIRELESS_ESSID="murmur"
MESH_MTU=""
NODE_NAME="keppler"

#source /etc/murmur/murmur.conf
source /home/$NODE_NAME/murmur/murmur.conf

echo Config Values
echo $BOOT_TYPE $STATIC_ADDRESS $WIRELESS_CHANNEL $WIRELESS_ESSID $MESH_MTU

 
#FUNCTIONS - - - - -

function provisionMurmur {

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
echo 'wireless-channel' $WIRELESS_CHANNEL | sudo tee --append /etc/network/interfaces.d/wlan0
echo 'wireless-essid' $WIRELESS_ESSID | sudo tee --append /etc/network/interfaces.d/wlan0
echo 'wireless-mode ad-hoc' | sudo tee --append /etc/network/interfaces.d/wlan0
echo Complete...

echo Stopping wpa services
sudo service wpa_supplicant stop

echo Starting boot...
sudo batctl if add wlan0
sudo ifconfig bat0 mtu $MESH_MTU
sudo ifconfig wlan0 up
sudo ifconfig bat0 up

#Setting Static Address
if [[ $STATIC_ADDRESS != "false" ]]; then
	echo Setting Static Address: $STATIC_ADDRESS
	sudo ifconfig bat0 $STATIC_ADDRESS
	fi
 
echo Provison ended.
}

function revertToWireless {
echo Using basic wireless. 
sudo rm /etc/network/interfaces.d/wlan0
echo If you are running this post start-up you will need to restart to reconnect.
}


#SCRIPT

# Log file location
#LOG_FILE="~/murmur/murmur.log"
# Function to log messages
#log() {
#  echo "$(date +"%Y-%m-%d %H:%M:%S") - $*" >> "$LOG_FILE"
#}
# Example usage
#log "Script started"

if [[ $BOOT_TYPE = "murmur" ]]; then
		provisionMurmur
	else
		revertToWireless
	fi

sudo systemctl restart networking
