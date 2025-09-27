#!/bin/bash
mkdir -p /var/run/mysqld && \
chown -R mysql:mysql /var/run/mysqld && \
chmod 777 /var/run/mysqld 
# Inicializa DB si está vacía
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# Arranca MariaDB
exec mysqld

