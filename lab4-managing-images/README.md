# Lab4 - Managing Docker images
This document guide you on how to manage Docker images via the "docker" utility

## Searching images

### Docker Hub
Note! This part of the lab is peformed on your workstation and not inside the VM
- Open your browser (like FireFox or Google Chrome)
- Open the link https://hub.docker.com
- Type "mariadb" in the search field
- Press ENTER

You should be able to see a list of mariadb-related images

- Click on the "> DETAILS" link on the right
- Scroll down the documenation


### docker search
- Check the "docker-search" man page

```
man docker-search
```

- Try to find an Apache image

```
docker search httpd
```

You should be able to see the following output:

```
[vagrant@node1 ~]$ docker search httpd
INDEX       NAME                                              DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
docker.io   docker.io/httpd                                   The Apache HTTP Server Project                  2204      [OK]
docker.io   docker.io/hypriot/rpi-busybox-httpd               Raspberry Pi compatible Docker Image with ...   45
docker.io   docker.io/centos/httpd                                                                            21                   [OK]
docker.io   docker.io/centos/httpd-24-centos7                 Platform for running Apache httpd 2.4 or b...   20
docker.io   docker.io/armhf/httpd                             The Apache HTTP Server Project                  8
docker.io   docker.io/tplatform/aws-linux-httpd24-php70       aws-linux-httpd24-php70                         3                    [OK]
docker.io   docker.io/salim1983hoop/httpd24                   Dockerfile running apache config                2                    [OK]
docker.io   docker.io/epflidevelop/os-wp-httpd                WP httpd                                        1                    [OK]
docker.io   docker.io/lead4good/httpd-fpm                     httpd server which connects via fcgi proxy...   1                    [OK]
docker.io   docker.io/ssarioglu/sample-httpd                  sample-httpd                                    1                    [OK]
docker.io   docker.io/tplatform/aws-linux-2-httpd24-php72     aws-linux-2-httpd24-php72                       1                    [OK]
docker.io   docker.io/tplatform/aws-linux-httpd24-php71       aws-linux-httpd24-php71                         1                    [OK]
docker.io   docker.io/tplatform/aws-linux-httpd24-php71-fpm   aws-linux-httpd24-php71-fpm                     1                    [OK]
docker.io   docker.io/amd64/httpd                             The Apache HTTP Server Project                  0
docker.io   docker.io/buzzardev/httpd                         Based on the official httpd image               0                    [OK]
docker.io   docker.io/dockerpinata/httpd                                                                      0
docker.io   docker.io/interlutions/httpd                      httpd docker image with debian-based confi...   0                    [OK]
docker.io   docker.io/itsziget/httpd24                        Extended HTTPD Docker image based on the o...   0                    [OK]
docker.io   docker.io/manageiq/httpd                          Container with httpd, built on CentOS for ...   0                    [OK]
docker.io   docker.io/manageiq/httpd_configmap_generator      Httpd Configmap Generator                       0                    [OK]
docker.io   docker.io/manasip/httpd                                                                           0
docker.io   docker.io/mprahl/s2i-angular-httpd24              An S2I image for building and running Angu...   0                    [OK]
docker.io   docker.io/publici/httpd                           httpd:latest                                    0                    [OK]
docker.io   docker.io/solsson/httpd-openidc                   mod_auth_openidc on official httpd image, ...   0                    [OK]
docker.io   docker.io/trollin/httpd                                                                           0
```

- Show 5 most popular mariadb images

```
docker search --limit 5 mariadb
```

- Look for official tomcat images

```
[vagrant@node1 ~]$ docker search -f is-official=true tomcat
INDEX       NAME               DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
docker.io   docker.io/tomcat   Apache Tomcat is an open source implementa...   2197      [OK]
docker.io   docker.io/tomee    Apache TomEE is an all-Apache Java EE cert...   59        [OK]
```

