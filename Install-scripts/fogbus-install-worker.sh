#!/bin/bash
# exit on any err
set -e

apt-get update
# apt-get upgrade -y
apt-get install dos2unix -y

### oracle-java8-jdk ###
mkdir -p /opt/jdk
tar -zxf jdk-8u202-linux-x64.tar.gz -C /opt/jdk
update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_202/bin/java 100
update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_202/bin/javac 100
##############

apt-get install ant git vim -y
apt-get install apache2 -y
echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf
apache2ctl configtest

#### php 7.2 ####
apt install libxml2-dev -y
tar -zxf jdk-8u202-linux-x64.tar.gz -C /tmp
cd /tmp/php-7.2.32
./configure
make -j 3 && make install
cd -
#################

apt-get install libapache2-mod-php php-mcrypt php-mysql -y
service apache2 restart
apt-get install mysql-server -y
mysql -u root -praspberry -e "CREATE DATABASE data;GRANT ALL PRIVILEGES ON data.* TO 'root'@'localhost' IDENTIFIED BY 'raspberry';FLUSH PRIVILEGES;"
service apache2 restart
sudo mkdir /var/www/html/HealthKeeper/
sudo chmod -R 777 /var/www/html/HealthKeeper/
sudo cp -a ./FogBus/Browser-src/RPi/Worker/* /var/www/html/HealthKeeper/
sudo chmod -R -f 777 /var/www/html/HeathKeeper/*
dos2unix ./FogBus/Run/*
chmod 777 ./FogBus/Run/*
cd /var/www/html/HealthKeeper/
sudo chmod -R -f 777 ./*
echo ".................................."
echo "Successfully Installed Raspi-Fog"
echo "Note the worker IP address :"
hostname -I
echo "Press Enter to run"
read
chromium-browser localhost/HealthKeeper/manager.php --no-sandbox &
java -jar WorkerInterface.jar
