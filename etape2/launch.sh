#!/bin/sh
docker build -t php-mysqli .
docker run -d --name data --network networkTP3 \
  -e MARIADB_RANDOM_ROOT_PASSWORD=yes \
  -v "$(pwd)/sql:/docker-entrypoint-initdb.d" mariadb:latest
docker run -d --name script --network networkTP3 -v "$(pwd)/src:/app" php-mysqli
docker run -d --name http --network networkTP3 -p 8080:80 \
  -v "$(pwd)/src:/app" \
  -v "$(pwd)/config/default.conf:/etc/nginx/conf.d/default.conf" nginx:latest
