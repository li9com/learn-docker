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


## Downloading images
- Check the "docker-pull" man page

```
man docker-pull
```

- Download an Apache image

```
[vagrant@node1 ~]$ docker pull httpd
Using default tag: latest
Trying to pull repository docker.io/library/httpd ...
latest: Pulling from docker.io/library/httpd
a5a6f2f73cd8: Pull complete
ac13924397e3: Pull complete
91b81769f14a: Pull complete
fec7170426de: Pull complete
992c7790d5f3: Pull complete
Digest: sha256:9753aabc6b0b8cd0a39733ec13b7aad59e51069ce96d63c6617746272752738e
Status: Downloaded newer image for docker.io/httpd:latest
```

- Make sure that image has been downloaded successfully

```
[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
```

- Download Apache image with tag 2.2

```
[vagrant@node1 ~]$ docker pull httpd:2.2
Trying to pull repository docker.io/library/httpd ...
2.2: Pulling from docker.io/library/httpd
f49cf87b52c1: Pull complete
24b1e09cbcb7: Pull complete
8a4e0d64e915: Pull complete
bcbe0eb4ca51: Pull complete
16e370c15d38: Pull complete
Digest: sha256:9784d70c8ea466fabd52b0bc8cde84980324f9612380d22fbad2151df9a430eb
Status: Downloaded newer image for docker.io/httpd:2.2
```

- Make sure that both images exist locally:

```
[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     2.2                 e06c3dbbfe23        10 months ago       171 MB
```

## Displaying downloaded images
- Check the "docker-images" man page

```
man docker-images
```

- Make sure that you downloaded images previously

```
docker images
```

Note! You should be able to see at least 2 images (httpd:latest and httpd:2.2)

- Display only image IDs

```
[vagrant@node1 ~]$ docker images -aq
2a51bb06dc8b
e06c3dbbfe23
```

- Apply a formatted output

```
[vagrant@node1 ~]$ docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"
IMAGE ID            REPOSITORY          TAG
2a51bb06dc8b        docker.io/httpd     latest
e06c3dbbfe23        docker.io/httpd     2.2


[vagrant@node1 ~]$ docker images --format "table {{.ID}}:{{.Tag}}\t{{.Repository}}"
IMAGE ID              TAG                 REPOSITORY
2a51bb06dc8b:latest   docker.io/httpd
e06c3dbbfe23:2.2      docker.io/httpd
```

## Tagging images
- Check the "docker-tag" man page

```
man docker-tag
```

- Tag the image "httpd" as "myapache"

```
[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     2.2                 e06c3dbbfe23        10 months ago       171 MB
[vagrant@node1 ~]$ docker tag httpd apache
```

- Make sure that "docker images" shows new tag

```
[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
apache              latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     2.2                 e06c3dbbfe23        10 months ago       171 MB
```

- Tag the httpd image with tag=2.2 as apache:v2.2

```
[vagrant@node1 ~]$ docker tag docker.io/httpd:2.2 apache:v2.2
[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
apache              latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     2.2                 e06c3dbbfe23        10 months ago       171 MB
apache              v2.2                e06c3dbbfe23        10 months ago       171 MB
```
