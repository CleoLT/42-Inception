FROM debian:bullseye

VOLUME /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY --chmod=700 ./tools/start-mariadb.sh /root/start-mariadb.sh

RUN apt update && \
    apt install -y mariadb-server


RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 777 /var/lib/mysql /var/run/mysqld

EXPOSE 3306


ENTRYPOINT ["/root/start-mariadb.sh"]

CMD ["mysqld"]
