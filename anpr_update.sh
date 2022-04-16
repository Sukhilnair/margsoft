#!/bin/bash
echo "Please mention the IP of the device where you want to change the config"
read ip
curl http://$ip:5000/uvanpr/v2/cameras
