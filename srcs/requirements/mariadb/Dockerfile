FROM debian:bullseye

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY --chmod=700 ./tools/start-mariadb.sh /start-mariadb.sh

RUN apt update -y && \
    apt install -y mariadb-server


RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 777 /var/lib/mysql /var/run/mysqld

EXPOSE 3306

ENTRYPOINT ["/start-mariadb.sh"]
