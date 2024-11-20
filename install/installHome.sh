#! /bin/bash

echo Provision Raspbian System for Murmur 1.03

echo Installing Script in Home Folder
sudo chmod +x ~/murmur/murmur-start.sh

echo Setting permision for log file
sudo chmod +777 ~/murmur


echo We need to add line to rc.local, this is what causes it to boot at start. 
echo The line is '/home/keppler/murmur/murmur-boot.sh &' and should be placed a line above the line 'exit 0'
echo Press any key when ready to open nano to change this. 
pause
sudo nano /etc/rc.local




#echo Starting provision for GPS
#sudo rm /etc/default/gpsd
#sudo rm /lib/systemd/system/gpsd.socket
#mv ~/murmur/gpsd-config-ow /etc/default/gpsd
#mv ~/murmur/gpsd-socket-config-ow /lib/systemd/system/gpsd.socket
