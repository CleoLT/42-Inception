FROM debian:bullseye

RUN apt update -y && \
    apt install -y php-fpm curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY --chmod=700 ./tools/start-wordpress.sh /start-wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/start-wordpress.sh"]
