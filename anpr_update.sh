#!/bin/bash
echo "Please mention the IP of the device where you want to change the config"
read ip
curl http://$ip:5000/uvanpr/v2/cameras > /tmp/list.txt
count=`cat /tmp/list.txt | wc -w`
i=1
if [ $i -le $count ]
then
    cut -d: -f $i /tmp/list.txt | grep CAM >> /tmp/list2.txt
    i=$(($i+1))
fi
cat /tmp/list2.txt
rm /tmp/list2.txt
    
