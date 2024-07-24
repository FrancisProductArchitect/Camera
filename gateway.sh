killall -9 pppd
killall -9 gsm0710muxd
killall tunslip6
ifconfig tun0 down
/usr/bin/tunslip6 aaaa::1/64 -s /dev/ttyO3 2> gar &
sleep 10
ifconfig tun0 up
sleep 2
/usr/bin/gsm-on.sh
sleep 5
pppd call gprs &
sleep 10
#/usr/bin/Gatway-to-ibm-cloud &
#echo "MQTT Process is running"
#sleep 3

---------------------------------------------------------------------------------------------------------------------------
cat wifi-router-configure.sh

killall wpa_supplicant
killall -9 wpa_supplicant
wpa_passphrase Pc-Network ezlo-bd5g-mes0 >> /etc/wpa_supplicant.conf
---------------------------------------------------------------------------------------------------------------------------
change "Pc-Network " name to different name : in "/usr/bin/wifi-auto-on.sh" 
---------------------------------------------------------------------------------------------------------------------------
#pingCheck.sh
#!/bin/bash

#for I in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
#PATH=/home/
for I in 1
do
ping -q -c3 www.google.com > /dev/null
if [ $? -eq 0 ]
then
echo $i "Pingable"
echo "Ping Success.."
value=`cat /sys/class/net/wlan0/address`
#text=.txt
#value=$value$text
DATE=$(date +"%d/%m/%Y, %H:%M")
echo $value "|" $DATE > /home/deviceid.txt
curl -T /home/deviceid.txt ftp://exampleOrg.com/MPU-LOGS/ --user fra:fra12345
else
echo $I "Not Pingable"
echo "Ping not Success.."
fi
done
---------------------------------------------------------------------------------------------------------------------------
root@nvidia-evm:~# cat /usr/bin/pingCheck.sh
#!/bin/bash
POScounterVal=0
NEGcounterVal=0
killall Detect-key
killall testKB_evm.dat
killall back
/etc/init.d/matrix-gui-2.0 stop
sleep 1
/usr/bin/wifi-auto-on.sh
echo "WIFI-PROCESS EXECUTED"
for I in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
#PATH=/home/
#for I in 1
do
ping -q -c3 www.google.com > /dev/null
if [ $? -eq 0 ]
then
        echo $I "Ping Success.."
        value=`cat /sys/class/net/wlan0/address`
        filename="${value}.txt"
        DATE=$(date +"%d/%m/%Y, %H:%M")
        ((POScounterVal=POScounterVal+1))
        echo $POScounterVal
else
        echo $I "Not Pingable"
        echo "Ping not Success.."
        killlall udhcpc
        killall -9 udhcpc
        sleep 2
        udhcpc -iwlan0 -n
        sleep 6
        ((NEGcounterVal=NEGcounterVal+1))
        echo $NEGcounterVal
#       killall Gatway-to-ibm-cloud
#       sleep 1
#       killall wega_client
#       sleep 1
#       killall -9 Gatway-to-ibm-cloud
#       sleep 1
#       killall -9 wega_client
#       sleep 1
#       killall wifi-auto-on.sh
#       sleep 1
#       /usr/bin/wifi-auto-on.sh &
#       sleep 50
fi
if [ $I -eq 14 ]
then
        if [ $POScounterVal -eq 14 ]
        then
                echo "POS Counter reached" $I $POScounterVal
                echo $filename "|" $DATE >> /home/deviceid.txt
                curl -T /home/deviceid.txt ftp://exampleOrg.com/MPU-LOGS/ --user hyd:sil12345
                sleep 4
#               /usr/bin/Gatway-to-ibm-cloud &
                echo "MQTT Process is running"
                sleep 3
        else
        if [ $NEGcounterVal -eq 14 ]
        then
                echo "NEG Counter reached" $I $NEGcounterVal
                echo "System Rebooting..."
                sleep 2
                /sbin/reboot
        else
                echo "none"
        fi
        fi
else
        echo ""
fi
done
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
root@nvidia-evm:~# cat /usr/bin/check.sh
PROCESS1=wpa_supplicant
PROCESS2=udhcpc
PROCESS3=Gatway-to-ibm-cloud
for (( ;; ))
do
if [ $(pidof $PROCESS1) > /dev/null ] ;
then
        retval='true';
        echo "running wpa supplicant"
else
        retval='false';
        echo "Not running wpa supplicant"
        /usr/bin/pingCheck.sh
fi;
if [ $(pidof $PROCESS2) > /dev/null ] ;
then
        retval='true';
        echo "running udhcpc"
else
        retval='false';
        echo "Not running udhcpc"
        /usr/bin/pingCheck.sh
fi;
if [ $(pidof $PROCESS3) > /dev/null ] ;
then
        retval='true';
        echo "running Gateway IOT"
else
        retval='false';
        echo "Not running Gateway IOT"
        /usr/bin/Gatway-to-ibm-cloud
fi;
sleep 3
done
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
root@nvidia-evm:~# cat rtctime.sh
TM=$(curl -s http://www.timeapi.org/utc/now?format=%25Y.%25m.%25d-%25H:%25M)
echo $TM
date "${TM}"
hwclock --systohc
date

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
Root@nvidia-evm:/usr/bin# cat pingCheck.sh
#!/bin/bash
POScounterVal=0
NEGcounterVal=0
killall Detect-key
killall testKB_evm.dat
killall back
/etc/init.d/matrix-gui-2.0 stop
sleep 1
/usr/bin/gprs-auto-on.sh
echo "GPRS-PROCESS EXECUTED"
for I in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
#PATH=/home/
#for I in 1
do
ping -q -c3 www.google.com > /dev/null
if [ $? -eq 0 ]
then
        echo $I "Ping Success.."
        value=`cat /sys/class/net/wlan0/address`
        filename="${value}.txt"
        DATE=$(date +"%d/%m/%Y, %H:%M")
        ((POScounterVal=POScounterVal+1))
        echo $POScounterVal
else
        echo $I "Not Pingable"
        echo "Ping not Success.."
        killlall udhcpc
        killall -9 udhcpc
        killall Gatway-to-ibm-cloud
        sleep 3
        /usr/bin/Gatway-to-ibm-cloud &
        sleep 5
        killall Gatway-to-ibm-cloud
        sleep 2
        ((NEGcounterVal=NEGcounterVal+1))
        echo $NEGcounterVal
fi
if [ $I -eq 14 ]
then
        if [ $POScounterVal -eq 14 ]
        then
                echo "POS Counter reached" $I $POScounterVal
                echo $filename "|" $DATE >> /home/deviceid.txt
#               curl -T /home/deviceid.txt ftp://exampleorg.com/MPU-LOGS/ --user hyd:sil12345
                sleep 1
                /usr/bin/rtctime.sh
                echo "MQTT Process is running"
        else
        if [ $NEGcounterVal -eq 14 ]
        then
                echo "NEG Counter reached" $I $NEGcounterVal
                echo "System Rebooting..."
                /sbin/reboot
        else
                echo "none"
        fi
        fi
else
        echo ""
fi
done
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
root@nvidia-evm:/usr/bin#
root@nvidia-evm:/usr/bin# cat check-gprs.sh
PROCESS1=pppd
PROCESS2=gsm0710muxd
PROCESS3=Gatway-to-ibm-cloud
MONITORcounterVal=0
for (( ;; ))
do
if [ $(pidof $PROCESS1) > /dev/null ] ;
then
        retval='true';
        echo "running pppd process"
else
        retval='false';
        echo "Not running pppd process"
        /usr/bin/pingCheck.sh
fi;
if [ $(pidof $PROCESS2) > /dev/null ] ;
then
        retval='true';
        echo "running gsm0710muxd"
else
        retval='false';
        echo "Not running gsm0710muxd"
        /usr/bin/pingCheck.sh
fi;
if [ $(pidof $PROCESS3) > /dev/null ] ;
then
        retval='true';
        echo "running Gateway IOT via GPRS"
        ((MONITORcounterVal=MONITORcounterVal+1))
        echo $MONITORcounterVal
        if [ $MONITORcounterVal -gt 100 ]
        then
                echo "Restarted the IOT MQTT Process"
                killall wega_client
                killall Gatway-to-ibm-cloud
                killall -9 wega_client
                killall -9 Gatway-to-ibm-cloud
                sleep 3
                /usr/bin/Gatway-to-ibm-cloud &
                sleep 15
                MONITORcounterVal=0
        else
                echo "None"
                echo $MONITORcounterVal
        fi
else
        retval='false';
        MONITORcounterVal=0
        echo "Not running Gateway IOT"
        killall wega_client
        /usr/bin/Gatway-to-ibm-cloud &
fi;
sleep 3
done
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
root@nvidia-evm:/usr/bin# cat reestablish-script.sh
/etc/init.d/matrix-gui-2.0 stop
killall Gatway-to-ibm-cloud
killall wega_client
killall -9 Gatway-to-ibm-cloud
killall -9 wega_client
sleep 1
#wifi-auto-on.sh &
/usr/bin/Gatway-to-ibm-cloud &
sleep 3
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
root@nvidia-evm:/usr/bin# cat /etc/init.d/demon-process
back &

bug &

#Batteryads-script.sh &

#/usr/bin/Auto0.5 &

#/usr/bin/gagan-on &
/usr/bin/check-gprs.sh &

exit 0
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
		GSM-ON.SH 
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
killall -9 backgroundgprs.sh
killall -9 gsm0710muxd
#backgroundgprs.sh &
#killall answer
rm /tmp/GSMON.flag
echo "0" > /sys/class/gpio/gpio62/value
sleep 1
echo "1" > /sys/class/gpio/gpio62/value
sleep 1
echo "0" > /sys/class/gpio/gpio62/value

rm /tmp/GSMON.flag
echo "0" > /sys/class/gpio/gpio62/value
sleep 1
echo "1" > /sys/class/gpio/gpio62/value
sleep 9
gsm0710muxd &
sleep 4
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
root@nvidia-evm:/usr/bin# cat /usr/bin/gprs-auto-on.sh
/usr/bin/gprs-off.sh
killall -9 pppd
killall -9 gsm0710muxdI
killall Gatway-to-ibm-cloud
killall -9 Gatway-to-ibm-cloud
killall tunslip6
killall -9 tunslip6
ifconfig tun0 down
ifconfig tun1 down
/usr/bin/tunslip6 aaaa::1/64 -s /dev/ttyO3 2> gar &
sleep 10
ifconfig tun0 up
sleep 2
/usr/bin/gsm-on.sh
sleep 5
pppd call AirTel &
sleep 10
root@nvidia-evm:/usr/bin#
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

root@nvidia-evm:~# cat /usr/bin/pingCheck.sh
#!/bin/bash
POScounterVal=0
NEGcounterVal=0
killall Detect-key
killall testKB_evm.dat
killall back
/etc/init.d/matrix-gui-2.0 stop
sleep 1
/usr/bin/gprs-auto-on.sh
echo "GPRS-PROCESS EXECUTED"
for I in 1 2 3 4 5 6 7 8 9 10
#PATH=/home/
#for I in 1
do
ping -q -c1 www.google.com > /dev/null
if [ $? -eq 0 ]
then
        echo $I "Ping Success.."
        value=`cat /sys/class/net/wlan0/address`
        filename="${value}.txt"
        DATE=$(date +"%d/%m/%Y, %H:%M")
        ((POScounterVal=POScounterVal+1))
        echo $POScounterVal
else
        echo $I "Not Pingable"
        echo "Ping not Success.."
        killlall udhcpc
        killall -9 udhcpc
        killall Gatway-to-ibm-cloud
        sleep 3
        /usr/bin/Gatway-to-ibm-cloud &
        sleep 5
        killall Gatway-to-ibm-cloud
        sleep 2
        ((NEGcounterVal=NEGcounterVal+1))
        echo $NEGcounterVal
#       killall Gatway-to-ibm-cloud
#       sleep 1
#       killall wega_client
#       sleep 1
#       killall -9 Gatway-to-ibm-cloud
#       sleep 1
#       killall -9 wega_client
fi
if [ $I -eq 10 ]
then
        if [ $POScounterVal -eq 10 ]
        then
                echo "POS Counter reached" $I $POScounterVal
                echo $filename "|" $DATE >> /home/deviceid.txt
#               curl -T /home/deviceid.txt ftp://exampleorg.com/MPU-LOGS/ --user hyd:sil12345
#               sleep 1
#               /usr/bin/rtctime.sh
#               /usr/bin/Gatway-to-ibm-cloud &
                echo "MQTT Process is running"
#               sleep 3
        else
        if [ $NEGcounterVal -eq 10 ]
        then
                echo "NEG Counter reached" $I $NEGcounterVal
                echo "System Rebooting..."
#               sleep 2
                /sbin/reboot
        else
                echo "none"
        fi
        fi
else
        echo ""
fi
done

root@nvidia-evm:~#
root@nvidia-evm:~#
root@nvidia-evm:~#
root@nvidia-evm:~# cat /usr/bin/check-gprs.sh
PROCESS1=pppd
PROCESS2=gsm0710muxd
PROCESS3=Gatway-to-ibm-cloud
MONITORcounterVal=0
for (( ;; ))
do
if [ $(pidof $PROCESS1) > /dev/null ] ;
then
        retval='true';
        echo "running pppd process"
else
        retval='false';
        echo "Not running pppd process"
        /usr/bin/pingCheck.sh
fi;
if [ $(pidof $PROCESS2) > /dev/null ] ;
then
        retval='true';
        echo "running gsm0710muxd"
else
        retval='false';
        echo "Not running gsm0710muxd"
        /usr/bin/pingCheck.sh
fi;
if [ $(pidof $PROCESS3) > /dev/null ] ;
then
        retval='true';
        echo "running Gateway IOT via GPRS"
        ((MONITORcounterVal=MONITORcounterVal+1))
        echo $MONITORcounterVal
        if [ $MONITORcounterVal -gt 900 ]
        then
                echo "Restarted the IOT MQTT Process"
                killall wega_client
                killall Gatway-to-ibm-cloud
                killall -9 wega_client
                killall -9 Gatway-to-ibm-cloud
                sleep 3
                /usr/bin/Gatway-to-ibm-cloud &
                sleep 5
                MONITORcounterVal=0
        else
                echo "None"
                echo $MONITORcounterVal
        fi
else
        retval='false';
        MONITORcounterVal=0
        echo "Not running Gateway IOT"
        killall wega_client
        /usr/bin/Gatway-to-ibm-cloud &
fi;
sleep 3
done


root@nvidia-evm:~# cat /usr/bin/reestablish-script.sh
/sbin/reboot
/etc/init.d/matrix-gui-2.0 stop
killall sleep
killall Gatway-to-ibm-cloud
killall wega_client
sleep 1
#wifi-auto-on.sh &
/usr/bin/Gatway-to-ibm-cloud &
sleep 1
