#!/bin/bash
apt update
apt install -y wget unzip php apache2 libapache2-mod-php php-zip

cd /var/www/
wget https://github.com/filegator/static/raw/master/builds/filegator_latest.zip
unzip filegator_latest.zip && rm filegator_latest.zip

chown -R www-data:www-data filegator/
chmod -R 775 filegator/

echo "
<VirtualHost *:80>
    DocumentRoot /var/www/filegator/dist
</VirtualHost>
" >> /etc/apache2/sites-available/filegator.conf

a2dissite 000-default.conf
a2ensite filegator.conf
systemctl restart apache2

exit