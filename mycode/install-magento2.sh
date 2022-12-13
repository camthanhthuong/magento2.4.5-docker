#!/bin/bash#

cd /var/www/html/magento2
sleep 2
composer install && bin/magento setup:install --base-url=http://magento.local:8080/ \
--db-host=127.0.0.1 --db-name=magento2 --db-user=magento2 --db-password=magento2 \
--admin-firstname=Magento --admin-lastname=User --admin-email=user@example.com \
--admin-user=admin --admin-password=admin123 --language=en_US \
--currency=USD --timezone=Asia/Ho_Chi_Minh --use-rewrites=1 \
--search-engine=elasticsearch7 --elasticsearch-host=127.0.0.1 \
--elasticsearch-port=9200 && bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=127.0.0.1 --page-cache-redis-port=6379 --page-cache-redis-db=0 && php bin/magento config:set admin/security/session_lifetime 86400 && php bin/magento cache:flush
