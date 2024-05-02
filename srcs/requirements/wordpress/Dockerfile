#BASE IMAGE
FROM        debian:bullseye

#DEFINE BUILD ARGUMENTS PASSED FROM docker-compose.yml
ARG         MYSQL_DATABASE
ARG         MYSQL_USER
ARG         MYSQL_PASSWORD
ARG         MYSQL_ROOT_PASSWORD

#UPDATE AND UPGRADE PACKAGES
RUN         apt-get -y update && apt upgrade
RUN         apt-get -y install wget php7.4-fpm php7.4-mysql mariadb-client

#CONFIGURE PHP TO COMMUNICATE WITH NGINX
RUN         mv /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.default
COPY        ./conf/www.conf /etc/php/7.4/fpm/pool.d/
RUN         ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

#EXPOSE PORT 9000
EXPOSE      9000

#CREATE PID DIRECTORY FOR PHP-FPM
RUN         mkdir -p /run/php
RUN         chmod 755 /run/php

#EXECUTE WORDPRESS INSTALLATION SCRIPT
COPY        ./tools/scrip.sh .
RUN         chmod +x ./scrip.sh

#START PHP-FPM
CMD  [ "./scrip.sh" ]