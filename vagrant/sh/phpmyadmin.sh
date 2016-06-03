#!/usr/bin/env bash

#Set the inputs for the interactive prompt of the PHPMyAdmin installation
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password my_pw" 
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password my_pw"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password my_pw"

apt-get install -y phpmyadmin
#Enable the php mcrypt extension for apache(Needed by PHPMyAdmin)
php5enmod mcrypt

#Create vhost entry
if [ -f /vagrant/tmp/phpmyadmin.conf ]; then
    mv /vagrant/tmp/phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf
    a2ensite phpmyadmin.conf
else
    >&2 echo "Error: phpmyadmin.conf not found"
fi

service apache2 restart
