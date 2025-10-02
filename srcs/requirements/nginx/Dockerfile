FROM debian:bullseye

RUN mkdir -p /etc/ssl

RUN apt update && \
    apt install nginx openssl -y 

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/nginx.key \
    -out /etc/ssl/nginx.crt \
    -subj "/C=ES/ST=CAT/L=BCN/O=EMPRESA/OU=IT Department/CN=localhost"
	#cambiar localhot por el dominio

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY --chmod=700 ./tools/start-nginx.sh /start-nginx.sh

EXPOSE 443

ENTRYPOINT [ "/start-nginx.sh" ]
