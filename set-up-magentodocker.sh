#!/bin/bash#

DIR_PATH=$(cd $(dirname “${BASH_SOURCE:-$0}”) && pwd)

echo ‘The directory path is’ $DIR_PATH

chown -R www-data:www-data $DIR_PATH/mycode
serviceName="docker"
if systemctl --all --type service | grep -q "$serviceName";then
    echo "$serviceName exists."
    chmod -R 777 elasticsearch-log/
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
    sleep 3
    mkdir -p /etc/apt/keyrings
    sleep 3
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sleep 3
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    sleep 3
    apt-get update
    sleep 3
    chmod a+r /etc/apt/keyrings/docker.gpg
    sleep 3
    apt-get update
    sleep 3
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    sleep 10
    chmod -R 777 elasticsearch-log/
    docker compose up -d
    sleep 20
    echo "sleep 20s"
    docker exec php-fpm sh install-magento2.sh
    chown -R www-data:www-data $DIR_PATH/mycode/magento2
    
fi
