#!/usr/bin/env bash

if [ -f /vagrant/tmp/mysite.conf ]; then
    chown $USER:$USER /var/www/html
    mv /vagrant/tmp/mysite.conf /etc/apache2/sites-available/mysite.conf
    a2ensite mysite.conf
else
    >&2 echo "Error: mysite.conf not found"
fi

#Make changes effective
service apache2 restart

