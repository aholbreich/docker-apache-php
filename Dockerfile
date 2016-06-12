# Includes
# Apache http server
# php5 with modules
# - curl
# - gd
# - pear
# - apc
# - mememcached
# 
# Please keep in mind that this might be not production ready because session is stored inside of container
FROM ubuntu:trusty

MAINTAINER Alexander Holbreich (http://alexander.holbreich.org) 

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
#        php5-mcrypt \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc  \
        php5-memcached \
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/*

#RUN /usr/sbin/php5enmod mcrypt
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

# Add application code on build of child image
#ONBUILD RUN rm -fr /app
ONBUILD ADD app /app

#Appache logs
VOLUME /var/log/apache2

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
