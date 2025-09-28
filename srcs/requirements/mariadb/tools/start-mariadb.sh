#!/bin/bash

echo "[ENTRYPOINT] Script iniciado"
set -x

# Inicializa DB si está vacía
#if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    #correr mariadb en segundo plano
    mysqld_safe --datadir=/var/lib/mysql &

    until [ -S /run/mysqld/mysqld.sock ]; do
        sleep 1
    done
    
    mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PW}';"
    mysql -u root --execute="ALTER USER 'root'@'%' IDENTIFIED BY '${DB_ROOT_PW}';"
    mysql -u root -p${DB_ROOT_PW} -e "DELETE FROM mysql.user WHERE User='';"
    
    mysql -u root -p${DB_ROOT_PW} -e "DROP DATABASE IF EXISTS test;"
    mysql -u root -p${DB_ROOT_PW} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    
    mysql -u root -p${DB_ROOT_PW} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    mysql -u root -p${DB_ROOT_PW} -e "CREATE USER IF NOT EXISTS '${DB_USER_NAME}'@'%' IDENTIFIED BY '${DB_USER_PW}';"
    mysql -u root -p${DB_ROOT_PW} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_NAME}'@'%';"
  
    mysql -u root -p${DB_ROOT_PW} -e "FLUSH PRIVILEGES;"
    mysqladmin -u root -p${DB_ROOT_PW} shutdown

#fi

#USER_EXISTS=$(mysql -u root -p"${DB_ROOT_PW}" -se "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user='${DB_USER_NAME}' AND host='%');")
#echo "HOLAAAAA ${USER_EXISTS}"

#if [ "$USER_EXISTS" -eq 0 ]; then
#    echo "\033[0;35mcreating database ${DB_NAME} and ${DB_USER_NAME} user\033[0m"
#    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql

    #correr mariadb en segundo plano
#    mysqld_safe --datadir=/var/lib/mysql &

    
#    mysql -u root -p${DB_ROOT_PW} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
#    mysql -u root -p${DB_ROOT_PW} -e "CREATE USER IF NOT EXISTS '${DB_USER_NAME}'@'%' IDENTIFIED BY '${DB_USER_PW}';"
#    mysql -u root -p${DB_ROOT_PW} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_NAME}'@'%';"
#    mysql -u root -p${DB_ROOT_PW} -e "FLUSH PRIVILEGES;"

  # mysqladmin -u root -p${DB_ROOT_PW} shutdown


#fi

#mysqladmin -u root -p${DB_ROOT_PW} shutdown
# Arranca MariaDB
exec mysqld

