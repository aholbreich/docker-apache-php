#!/bin/bash
chown www-data:www-data /app -R

# sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
#Defines variable order. see details here: http://php.net/manual/de/ini.core.php#ini.variables-order 
# sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
# Need for corect localhost behaviour
# echo "ServerName localhost" >> /etc/apache2/apache2.conf 

#Enable modede rewrite
#a2enmod rewrite

source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND