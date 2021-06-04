#!/bin/sh
export $(grep -v '^#' .env | xargs -d '\n')
args = ""
for var in "$@"
do
    args="$args $var"
done
eval exec "docker-compose exec $PHP_CONTAINER php$args"