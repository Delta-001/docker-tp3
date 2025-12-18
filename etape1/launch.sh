#!/bin/sh
docker network create networkTP3
docker run -d --name script --network networkTP3 -v "$(pwd)/src:/app" php:8.2-fpm
docker run -d --name http --network networkTP3 -p 8080:80 \
  -v "$(pwd)/src:/app" \
  -v "$(pwd)/config/default.conf:/etc/nginx/conf.d/default.conf" nginx:latest
