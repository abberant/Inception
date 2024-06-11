#BASE IMAGE
FROM        debian:bullseye

#DEFINE BUILD ARGUMENTS PASSED FROM docker-compose.yml
ARG         MYSQL_DATABASE
ARG         MYSQL_USER
ARG         MYSQL_PASSWORD
ARG         MYSQL_ROOT_PASSWORD

#UPDATE AND UPGRADE PACKAGES
RUN         apt -y update && apt -y upgrade
RUN         apt -y install mariadb-server mariadb-client

#COPY THE MARIADB CONFIGURATION FILE AND dump.sql FILE
COPY        ./conf/mariadb.cnf /etc/mysql/my.cnf
RUN         chmod 640 /etc/mysql/my.cnf
RUN         chown -R mysql:mysql /var/lib/mysql

#EXECURE MARIADB INSTALLATION SCRIPT
COPY        ./tools/install.sh /usr/local/bin/
RUN         chmod +x /usr/local/bin/install.sh

#EXPOSE PORT 3306
EXPOSE      3306

#START MARIADB
CMD  [ "./usr/local/bin/install.sh" ]