FROM debian:bullseye

RUN apt update -y && \
    apt install -y php7.4 php-fpm curl mariadb-client php-mysql

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php && chmod 755 /run/php

COPY --chmod=700 ./tools/start-wordpress.sh /start-wordpress.sh 

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/start-wordpress.sh"]
