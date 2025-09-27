FROM debian:bullseye

VOLUME /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY --chmod=700 ./tools/start-mariadb.sh /root

RUN apt update && \
    apt install -y mariadb-server


RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 777 /var/lib/mysql

EXPOSE 3306


ENTRYPOINT ["/root/start-mariadb.sh"]

CMD ["mysqld"]
