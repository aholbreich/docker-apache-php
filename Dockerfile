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
FROM debian:jessie

MAINTAINER Alexander Holbreich (http://alexander.holbreich.org) 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -yq install \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc  \
        php5-memcached \
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/*

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

