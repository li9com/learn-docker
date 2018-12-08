# Lab8 - Starting multicontainer application
In this lab you will start 2-tier application - WordPress.  WordPress requires access to a mysql database.

## Start mariadb database

- Prepare persistent storage

```
sudo mkdir -p /data/wp_db
sudo chcon -t container_file_t /data/wp_db
```

- Start a mariadb container
```
docker run -d --name mariadb \
   -v /data/wp_db:/var/lib/mysql \
   -e MYSQL_ROOT_PASSWORD=secret \
   -e MYSQL_USER=wp_user \
   -e MYSQL_PASSWORD=wp_password \
   -e MYSQL_DATABASE=wp_db \
   mariadb
```

- Make sure that container works

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS               NAMES
fde0bbf18699        mariadb             "docker-entrypoint..."   About a minute ago   Up About a minute   3306/tcp            mariadb


[vagrant@node1 /]$ docker exec  mariadb mysql -uwp_user -pwp_password -h127.0.0.1 -e 'show databases' wp_db
Database
information_schema
wp_db
```

## WordPress service
- Check WordPress image documentation accessible via

```
https://hub.docker.com/_/wordpress
```

- Pull the wordpress image

```
docker pull wordress
```

- Inspect wordpress image

```
[vagrant@node1 ~]$ docker inspect --format='{{ .Config.Volumes }}' wordpress
map[/var/www/html:{}]
```

Note! We need to mount a volume to /var/www/html.

- Configure WordPress persistent storage

```
sudo mkdir -p /data/wp_html
sudo chcon -t container_file_t /data/wp_html
```

- Start WordPress container and link it to the "mariadb" container we started recently

```
docker run -d --name wordpress \
  -p 8080:80 \
  -v /data/wp_html:/var/www/html \
  --link mariadb:mysql \
  wordpress
```

- Make sure that container works

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
abe229783f60        wordpress           "docker-entrypoint..."   41 seconds ago      Up 40 seconds       0.0.0.0:8080->80/tcp   wordpress
fde0bbf18699        mariadb             "docker-entrypoint..."   12 minutes ago      Up 12 minutes       3306/tcp               mariadb
```

- Make sure that container uses persistent storage

```
[vagrant@node1 ~]$ ls -l /data/wp_html/
total 196
-rw-r--r--.  1 33 tape   418 Sep 25  2013 index.php
-rw-r--r--.  1 33 tape 19935 Jan  6  2018 license.txt
-rw-r--r--.  1 33 tape  7415 Mar 18  2018 readme.html
-rw-r--r--.  1 33 tape  5458 May  1  2018 wp-activate.php
drwxr-xr-x.  9 33 tape  4096 Aug  2 20:39 wp-admin
-rw-r--r--.  1 33 tape   364 Dec 19  2015 wp-blog-header.php
-rw-r--r--.  1 33 tape  1889 May  2  2018 wp-comments-post.php
-rw-r--r--.  1 33 tape  3148 Dec  4 07:50 wp-config.php
-rw-r--r--.  1 33 tape  2764 Dec  4 07:50 wp-config-sample.php
drwxr-xr-x.  4 33 tape  4096 Aug  2 20:39 wp-content
-rw-r--r--.  1 33 tape  3669 Aug 20  2017 wp-cron.php
drwxr-xr-x. 18 33 tape 12288 Aug  2 20:39 wp-includes
-rw-r--r--.  1 33 tape  2422 Nov 21  2016 wp-links-opml.php
-rw-r--r--.  1 33 tape  3306 Aug 22  2017 wp-load.php
-rw-r--r--.  1 33 tape 37794 Jul 16 14:14 wp-login.php
-rw-r--r--.  1 33 tape  8048 Jan 11  2017 wp-mail.php
-rw-r--r--.  1 33 tape 16246 Oct  4  2017 wp-settings.php
-rw-r--r--.  1 33 tape 30091 Apr 29  2018 wp-signup.php
-rw-r--r--.  1 33 tape  4620 Oct 23  2017 wp-trackback.php
-rw-r--r--.  1 33 tape  3065 Aug 31  2016 xmlrpc.php
```

- Try to access the WordPress application using the following links
http://node1.172.24.0.11.nip.io:8080
http://172.24.0.11:8080

- Finish WordPress installation
- Make sure that you are not asked to provide any database details
