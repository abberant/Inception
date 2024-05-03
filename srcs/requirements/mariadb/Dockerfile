#BASE IMAGE
FROM        debian:bullseye

#DEFINE BUILD ARGUMENTS PASSED FROM docker-compose.yml
ARG         MYSQL_DATABASE
ARG         MYSQL_USER
ARG         MYSQL_PASSWORD
ARG         MYSQL_ROOT_PASSWORD
ARG         MYSQL_HOST

#UPDATE AND UPGRADE PACKAGES
RUN         apt -y update && apt -y upgrade
RUN         apt -y install mariadb-server mariadb-client

#ALLOW MYSQLD DAEMON TO RUN, PURGE AND RECREATE /var/lib/mysql WITH APPROPRIATE PERMISSIONS
# RUN         mkdir -p /var/lib/mysql /var/run/mysqld
# RUN         chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
# RUN         chmod +x /var/run/mysqld
COPY        ./tools/install.sh .

#COPY THE MARIADB CONFIGURATION FILE
COPY        ./conf/mariadb.cnf /etc/mysql/my.cnf
# RUN         chmod +x /etc/mysql/mariadb.conf.d/mariadb.cnf
#COPY        ./conf/dump.sql /usr/local/bin/

#EXECUTE MARIADB INSTALLATION SCRIPT
RUN        chmod +x install.sh

#EXPOSE PORT 3306
EXPOSE      3306

#START MARIADB
ENTRYPOINT  [ "./install.sh" ]