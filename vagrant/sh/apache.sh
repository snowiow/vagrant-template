#!/usr/bin/env bash

apt-get install -y apache2

#Symlink the apache webspace to the shared folder of the host and guest system
if ! [ -L /var/www/html ]; then
    rm -rf /var/www/html
    ln -fs /vagrant/projects /var/www/html
fi

#Copy the apache2.conf to the right location
if [ -f /vagrant/tmp/apache2.conf ]; then
    mv /vagrant/tmp/apache2.conf /etc/apache2/apache2.conf
else
    >&2 echo "Error: apache2.conf not found"
fi

#grant permission to webserver and logs
chmod -R 777 /var/www
chmod -R 755 /var/log

#enable mod_rewrite
a2enmod rewrite
