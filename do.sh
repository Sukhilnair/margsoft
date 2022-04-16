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
echo "Do you want to activate/deactivate, type anything else for exit"
read todo
    if [ "$todo" == "activate" ]
    then
            echo "Please mention which instance: "
            read inst
            curl -X PUT "http://0.0.0.0:5000/uvanpr/v2/cameras/$inst" -d '{ "activated": true }' -H "Content-Type: application/json"
    elif ["$todo" == "deactivate" ]
    then
            echo "Please mention which instance: "
            read inst
            curl -X PUT "http://0.0.0.0:5000/uvanpr/v2/cameras/$inst" -d '{ "activated": false }' -H "Content-Type: application/json"
    else
            sleep 2
    fi
