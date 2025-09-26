FROM debian:bullseye

VOLUME /var/lib/mysql

RUN apt update && \
    apt install -y --no-install-recommends mariadb-server

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chmod 777 /run/mysql

ENTRYPOINT ["mariadbd"]

