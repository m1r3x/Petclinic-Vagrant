#!/usr/bin/env bash

#checking for updates and installing mysql server if not installed already.
sudo apt-get update --fix-missing -y && sudo apt-get install -qq mysql-server

#making mysql server accessible from all ips, not just localhost.
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

#defining mysql queries as variables
q1="CREATE DATABASE IF NOT EXISTS $DBNAME;"
q2="CREATE USER IF NOT EXISTS '$DBUSER'@'192.168.1.%' IDENTIFIED BY '$DBPASSWD';"
q3="GRANT ALL ON $DBNAME.* TO '$DBUSER'@'192.168.1.%';"
Q="${q1}${q2}${q3}"

#running the queries
sudo mysql -e "$Q" 2>/dev/null

echo "Database $DBNAME and user $DBUSER are created."

#restarting mysql service to apply changes
sudo service mysql restart
