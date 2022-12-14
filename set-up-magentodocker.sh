#!/bin/bash#

DIR_PATH=$(cd $(dirname “${BASH_SOURCE:-$0}”) && pwd)

echo ‘The directory path is’ $DIR_PATH

chown -R www-data:www-data $DIR_PATH/mycode
serviceName="docker"
if systemctl --all --type service | grep -q "$serviceName";then
    echo "$serviceName exists."
    mkdir -p elasticsearch-log/elastic
    mkdir -p elasticsearch-log/logs
    mkdir -p elasticsearch-log/elastic
    mkdir nginx-log
    mkdir php8.1-fpm-log
    mkdir data-mysqldb
    chmod -R 777 elasticsearch-log/
    chmod -R 777 nginx-log
    chmod -R 777 php8.1-fpm-log
    chmod -R 777 data-mysqldb
    docker compose up -d
    sleep 20
    echo "sleep 20s"
    docker exec php-fpm sh install-magento2.sh
    chown -R www-data:www-data $DIR_PATH/mycode/magento2
else
    echo "$serviceName does NOT exist."
    apt-get update
    apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    sleep 1
    mkdir -p /etc/apt/keyrings
    sleep 1s
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sleep 1
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    sleep 1
    apt-get update
    sleep 1
    chmod a+r /etc/apt/keyrings/docker.gpg
    sleep 1
    apt-get update
    sleep 1
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    echo 'sleep 20s'
    sleep 20
    mkdir -p elasticsearch-log/elastic
    mkdir -p elasticsearch-log/logs
    mkdir -p elasticsearch-log/elastic
    mkdir nginx-log
    mkdir php8.1-fpm-log
    mkdir data-mysqldb
    chmod -R 777 elasticsearch-log/
    chmod -R 777 nginx-log
    chmod -R 777 php8.1-fpm-log
    chmod -R 777 data-mysqldb
    docker compose up -d
    docker exec php-fpm sh install-magento2.sh
    chown -R www-data:www-data $DIR_PATH/mycode/magento2
fi
