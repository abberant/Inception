#BASE IMAGE
FROM        debian:bullseye

#DEFINE BUILD ARGUMENTS PASSED FROM docker-compose.yml
ARG         DOMAIN_NAME
ARG         CERTS_KEY
ARG         CERTS_CRT

#UPDATE AND UPGRADE PACKAGES
RUN         apt-get update && apt-get upgrade -y
RUN         apt-get install -y nginx openssl mariadb-client


#GENERATE SELF-SIGNED CERTIFICATES
RUN         openssl req -x509 -nodes \
                    -days 365 \
                    -newkey rsa:2048 \
                    -keyout /etc/ssl/private/nginx-selfsigned.key \
                    -out /etc/ssl/certs/nginx-selfsigned.crt \
                    -subj "/C=MO/L=BG/O=1337/OU=student/CN=${DOMAIN_NAME}"


#COPY NGINX CONFIGURATION FILE
COPY        ./conf/https.conf /etc/nginx/conf.d/default.conf

#EXPOSE PORT 443
EXPOSE      443

#START NGINX
ENTRYPOINT  ["nginx", "-g", "daemon off;"]