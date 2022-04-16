#!/bin/bash
#echo "Please mention the IP of the device where you want to change the config"
#read ip
curl http://0.0.0.0:5000/uvanpr/v2/cameras > /tmp/list.txt
count=`cat /tmp/list.txt | wc -w`
i=1
while [ $i -le $count ]
do
    cut -d: -f $i /tmp/list.txt | grep CAM >> /tmp/list2.txt
    #echo $i
    i=$(($i+1))
done
echo "##############################################################################################################################"
echo "Cameras Which are active:"
cat /tmp/list2.txt
rm /tmp/list2.txt
echo "##############################################################################################################################"
