#BASE IMAGE
FROM        debian:bullseye

#DEFINE BUILD ARGUMENTS PASSED FROM docker-compose.yml
ARG         DOMAIN_NAME
ARG         CERTS_KEY
ARG         CERTS_CRT

#UPDATE AND UPGRADE PACKAGES
RUN         apt-get update && apt-get upgrade -y
RUN         apt-get install -y nginx openssl

#GENERATE SELF-SIGNED CERTIFICATES
RUN         openssl req -x509 -nodes \
                    -days 365 \
                    -newkey rsa:2048 \
                    -keyout /etc/ssl/private/${CERTS_KEY} \
                    -out /etc/ssl/certs/${CERTS_CRT} \
                    -subj "/C=FR/ST=Morocco/L=Morocco/O=1337/CN=${DOMAIN_NAME}"

#GUARANTEE THAT NGINX IS USING TSLSV1.3
RUN         sed -i 's/ssl_protocols.*/ssl_protocols TSLSV3;/' /etc/nginx/nginx.conf

#COPY NGINX CONFIGURATION FILE
COPY        ./conf/https.conf /etc/nginx/conf.d/
RUN         sed -i "s|aanouari.42.fr|${DOMAIN_NAME}|g" /etc/nginx/conf.d/https.conf
RUN         sed -i "s|/etc/ssl/private/nginx-selfsigned.key|${CERTS_CRT}|g" /etc/nginx/conf.d/https.conf
RUN         sed -i "s|/etc/ssl/certs/nginx-selfsigned.crt|${CERTS_KEY}|g" /etc/nginx/conf.d/https.conf

#EXPOSE PORT 443
EXPOSE      443

#START NGINX
ENTRYPOINT  ["nginx", "-g", "daemon off;"]