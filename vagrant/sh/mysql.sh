#!/usr/bin/env bash

#Set the inputs for the interactive prompt of the MySQL installation
debconf-set-selections <<< "mysql-server mysql-server/root_password password my_pw"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password my_pw"
apt-get install -y mysql-server 

#Copy the my.cnf to the right location
if [ -f /vagrant/tmp/mysqld.cnf ]; then
    mv /vagrant/tmp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
else
    >&2 echo "Error: mysqld.cnf not found"
fi

systemctl restart mysql
