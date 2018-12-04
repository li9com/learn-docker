#!/bin/bash
docker run -d --name mariadb \
   -v /data/wp_db:/var/lib/mysql \
   -e MYSQL_ROOT_PASSWORD=secret \
   -e MYSQL_USER=wp_user \
   -e MYSQL_PASSWORD=wp_password \
   -e MYSQL_DATABASE=wp_db \
   mariadb
