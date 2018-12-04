#!/bin/bash
docker run -d --name wordpress \
  -p 8080:80 \
  -v /data/wp_html:/var/www/html \
  --link mariadb:mysql \
  wordpress
