#!/bin/bash
# Database Tier - MySQL only
DB_NAME="${db_name}"
DB_USERNAME="${db_username}"
DB_PASSWORD="${db_password}"

sudo apt update -y
sudo apt install -y mysql-server

# Configure MySQL for remote connections
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl start mysql
sudo systemctl enable mysql

# Wait for MySQL to be ready
sleep 10

# Create database and user
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"

sudo systemctl restart mysql

# Log for debugging
echo "DB tier configured: $DB_NAME" >> /tmp/db-setup.log