#!/bin/sh
export $(grep -v '^#' .env | xargs -d '\n')
if [ "$1" = "build" ]; then
    if test -f "docker-compose.yaml"; then
       rm docker-compose.yaml
    fi
    if test -f "docker-compose.conf"; then
       rm nginx/pre-default.conf
    fi
    cp pre-docker-compose.yaml docker-compose.yaml
    cp nginx/pre-default.conf nginx/default.conf
    sed -i "s/container_php/$PHP_CONTAINER/" ./nginx/default.conf
    sed -i "s/server_name_url/$SERVER_NAME/" ./nginx/default.conf
    sed -i "s/container_php/$PHP_CONTAINER/" ./docker-compose.yaml
    sed -i "s/container_mysql/$MYSQL_CONTAINER/" ./docker-compose.yaml
    sed -i "s/container_nginx/$NGINX_CONTAINER/" ./docker-compose.yaml
    sed -i "s/port_host/$NGINX_PORT/" ./docker-compose.yaml
    sed -i "s/port_local_db/$MYSQL_PORT/" ./docker-compose.yaml
    sed -i "s/name_networks/$NAME_NETWORKS/" ./docker-compose.yaml
    echo "Для запуску ведіть команду: docker-compose up -d"
fi