#! /bin/bash

echo Provision Raspbian System for Murmur 1.03

echo Installing Script at /usr/local/bin/
sudo rm /usr/local/bin/murmur-start.sh
sudo mv ~/murmur/murmur-start.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/murmur-start.sh

echo Installing Config at /etc/murmur
sudo mkdir /etc/murmur
sudo rm /etc/murmur/murmur.conf
sudo mv ~/murmur/murmur.conf /etc/murmur/

echo We need to add line to rc.local, this is what causes it to boot at start. 
echo The line is '/usr/local/bin/murmur-boot.sh &' and should be placed a line above the line 'exit 0'
echo Press any key when ready to open nano to change this. 
pause
sudo nano /etc/rc.local




#echo Starting provision for GPS
#sudo rm /etc/default/gpsd
#sudo rm /lib/systemd/system/gpsd.socket
#mv ~/murmur/gpsd-config-ow /etc/default/gpsd
#mv ~/murmur/gpsd-socket-config-ow /lib/systemd/system/gpsd.socket
