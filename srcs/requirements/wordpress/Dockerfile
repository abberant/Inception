#BASE IMAGE
FROM        debian:bullseye

#DEFINE BUILD ARGUMENTS PASSED FROM docker-compose.yml
ARG         MYSQL_DATABASE
ARG         MYSQL_USER
ARG         MYSQL_PASSWORD
ARG         MYSQL_ROOT_PASSWORD

#UPDATE AND UPGRADE PACKAGES
RUN         apt -y update && apt -y upgrade
RUN         apt-get -y install wget php7.4-fpm php7.4-mysql mariadb-client


#EXPOSE PORT 9000
EXPOSE      9000

#CREATE PID DIRECTORY FOR PHP-FPM
RUN         mkdir -p /run/php
RUN         chmod 755 /run/php

#EXECUTE WORDPRESS INSTALLATION SCRIPT
COPY        ./tools/install.sh .
RUN         chmod +x ./install.sh

#START PHP-FPM
CMD  [ "./install.sh" ]