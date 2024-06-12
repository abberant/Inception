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

#COPY THE MARIADB CONFIGURATION FILE
COPY        ./conf/mariadb.cnf /etc/mysql/my.cnf
RUN         chmod 640 /etc/mysql/my.cnf
RUN         chown -R mysql:mysql /var/lib/mysql

#EXECUTE MARIADB INSTALLATION SCRIPT
COPY        ./tools/install.sh .
RUN         chmod +x ./install.sh

#EXPOSE PORT 3306
EXPOSE      3306

#START MARIADB
CMD  [ "./install.sh" ]