#!/usr/bin/env bash

#Set the inputs for the interactive prompt of the MySQL installation
debconf-set-selections <<< "mysql-server mysql-server/root_password password my_pw"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password my_pw"
apt-get install -y mysql-server libapache2-mod-auth-mysql 

#Copy the my.cnf to the right location
if [ -f /vagrant/tmp/my.cnf ]; then
    mv /vagrant/tmp/my.cnf /etc/mysql/my.cnf
else
    >&2 echo "Error: my.cnf not found"
fi

service mysql restart
