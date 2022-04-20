sudo apt-get install curl -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y
sudo docker run hello-world

sudo apt-get install openssh-server -y
sudo apt-get install vim -y

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
sudo docker login --username uvcustomer -p 'Uncanny!2#'
sudo docker-compose -f /home/$USER/External_Storage/docker-compose.yml up -d
sleep 10
sudo docker-compose down
i=1
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo number of instances:
read number
while [ $i -le $number ]
do
       sudo cp ./config_$i.json /home/$USER/External_Storage/uncanny/instance$i/config/config.json
       sudo cp ./client_$i.json /home/$USER/External_Storage/uncanny/sink/client/client_$i.json
       sudo cp ./pm2_app_$i.json /home/$USER/External_Storage/uncanny/sink/pm2_app.json
       sudo cp ./config_sink_$i.json /home/$USER/External_Storage/uncanny/sink/config/config_$i.json
       i=$(($i+1))
done
if [ $i -eq 2 ]
then
        sudo cp ./anpr.json /home/$USER/External_Storage/uncanny/anpr/
fi   
git clone https://github.com/Sukhilnair/Release_license.git
cd Release_licese
sudo mkdir bin
mv test_license bin/
mv license_generator bin/
cd ../
echo "Copied all needful files. Restarting ANPR and SINK
sudo docker restart anpr sink
echo *****************Installtion Done*********************
echo "Docker Pulled:"
sudo docker images
echo Please contact Uncanny Vision for license installtion.
echo *********************Thank You*************************
