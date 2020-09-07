#!/bin/bash

# exit on any err
set -e

apt-get update
# Not really neccessary to upgrade
# apt-get upgrade -y

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
apt install libxml2-dev gcc -y
tar -zxf php-7.2.32.tar.gz -C /tmp
cd /tmp/php-7.2.32
./configure
make -j 3 && make install
cd -
#################

apt-get install libapache2-mod-php php-mysql -y

### php-mycrypt ###
# php-mcrypt has been deprecated in PHP 7.2
# https://askubuntu.com/questions/1031921/php-mcrypt-package-missing-in-ubuntu-server-18-04-lts
apt-get install libmcrypt-dev gcc make autoconf libc-dev pkg-config && pecl install mcrypt-1.0.1
###############

### mysql server 5.7
tar -zxf mysql-boost-5.7.31.tar.gz -C /tmp
mkdir -p /tmp/mysql-5.7.31/bld && cd /tmp/mysql-5.7.31/bld
sudo apt-get install libncurses5-dev -y
cmake -DWITH_BOOST=/tmp/mysql-5.7.31/boost ..
make -j3 && make install 
cd -
#EtqD#zj3JubS
sudo apt install mysql-client-core-5.7 mysql-server-core-5.7 -y

mysql -u root -praspberry -e "CREATE DATABASE data;GRANT ALL PRIVILEGES ON data.* TO 'root'@'localhost' IDENTIFIED BY 'raspberry';FLUSH PRIVILEGES;"
service apache2 restart
mkdir /var/www/html/HealthKeeper/
chmod -R 777 /var/www/html/HealthKeeper/
chmod -R 777 /var/www/html/HealthKeeper/RPi/
cp -a ./FogBus/Browser-src/* /var/www/html/HealthKeeper/
chmod 777 /var/www/html/HealthKeeper/RPi/
chmod 777 /var/www/html/HealthKeeper/RPi/Master/*
chmod 777 /var/www/html/HealthKeeper/RPi/Worker/*
echo ".................................."
echo "Successfully Installed Raspi-Fog"
echo "Note the Master IP address :"
hostname -I
echo "Configure Database as described in End-User Tutorial then press Enter to run"
read

apt install chromium-browser
chromium-browser localhost/HealthKeeper/RPi/Master/ --no-sandbox &
cd /var/www/html/HealthKeeper/RPi/Master/
java -jar MasterInterface.jar


