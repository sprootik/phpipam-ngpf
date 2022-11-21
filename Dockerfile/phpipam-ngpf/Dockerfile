FROM alpine:3.15

ARG VERSION="v1.5.0"
ENV MODE=""
ENV DLR="$"
ENV PHP_FPM_HOST="127.0.0.1"
ENV PHP_FPM_PORT="9000"
ENV NGINX_PORT="80"

LABEL name="phpIPAM Nginx & php-fpm Container" \
      version=$VERSION \
      maintainer="sprootik <sprootik89@gmail.com>"

WORKDIR /

# php
RUN apk upgrade --no-cache
RUN apk add --no-cache alpine-conf mariadb-client \
      php php-cli php-pear php-pdo_mysql php-json php-session php-gmp php-gd php-sockets php-gettext php-mbstring \
      php-ctype php-ldap php-curl php-snmp php-openssl php-simplexml php-pcntl php-iconv php-opcache php-posix php-dom iputils fping \
      php7-sockets php7-gmp php7-gettext php7-pdo_mysql php7-gd php-fpm
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php7/php-fpm.d/www.conf

# nginx
RUN apk add --no-cache nginx gettext
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# supervisor
RUN apk add --no-cache supervisor

# date
RUN apk add --no-cache tzdata
ENV TZ=Asia/Vladivostok

# config
COPY root/ /
RUN chmod +x /entrypoint.sh

# IPAM
RUN apk add git && git clone https://github.com/phpipam/phpipam.git && \
      cd /phpipam && git checkout $VERSION && rm -rf .git* 
# IPAM permision
RUN find /phpipam -type f -exec chmod u=rw,go=r {} \; && \
      find /phpipam -type d -exec chmod u=rwx,go=rx {} \; && \
      find /phpipam -type d -name upload -exec chmod a=rwx {} \; && \
      chmod a=rwX /phpipam/css/images/logo
# IPAM base config
RUN ln -s /phpipam/config.docker.php /phpipam/config.php && \
      sed -i 's/$api_allow_unsafe = false;/$api_allow_unsafe = true;/g' /phpipam/config.dist.php


# run
EXPOSE 9000 80
CMD ["/entrypoint.sh", "$MODE"]
