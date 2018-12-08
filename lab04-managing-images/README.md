# Lab4 - Managing Docker images
This document will guide you on how to manage Docker images via the "docker" utility

## Searching images

### Docker Hub
Note! This part of the lab is peformed on your workstation and not inside the VM
- Open your browser (like FireFox or Google Chrome)
- Open the link https://hub.docker.com
- Type "mariadb" in the search field
- Press ENTER

You should be able to see a list of mariadb-related images

- Click on the "> DETAILS" link on the right
- Scroll down trough the documenation

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

- Make sure that both images do exist locally:

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

## Getting image information
- Check the "docker-history" man page

```
man docker-history
```

- Display the httpd image history

```
[vagrant@node1 learn-docker]$ docker history httpd
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
2a51bb06dc8b        2 weeks ago         /bin/sh -c #(nop)  CMD ["httpd-foreground"]     0 B
<missing>           2 weeks ago         /bin/sh -c #(nop)  EXPOSE 80/tcp                0 B
<missing>           2 weeks ago         /bin/sh -c #(nop) COPY file:761e313354b918...   133 B
<missing>           2 weeks ago         /bin/sh -c set -eux;   savedAptMark="$(apt...   43.1 MB
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV APACHE_DIST_URLS=ht...   0 B
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV HTTPD_PATCHES=           0 B
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV HTTPD_SHA256=3498dc...   0 B
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV HTTPD_VERSION=2.4.37     0 B
<missing>           2 weeks ago         /bin/sh -c set -eux;  apt-get update;  apt...   33.3 MB
<missing>           2 weeks ago         /bin/sh -c #(nop) WORKDIR /usr/local/apache2    0 B
<missing>           2 weeks ago         /bin/sh -c mkdir -p "$HTTPD_PREFIX"  && ch...   0 B
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV PATH=/usr/local/apa...   0 B
<missing>           2 weeks ago         /bin/sh -c #(nop)  ENV HTTPD_PREFIX=/usr/l...   0 B
<missing>           2 weeks ago         /bin/sh -c #(nop)  CMD ["bash"]                 0 B
<missing>           2 weeks ago         /bin/sh -c #(nop) ADD file:dab9baf938799c5...   55.3 MB
```

- Try to Check history of the following images: mariadb, centos:7, wildfly
Note! This may require to pull images first

- Check the "docker-inspect" man page

```
man docker-inspect
```

- Inspect the httpd image

```
[vagrant@node1 ~]$ docker inspect httpd
[
    {
        "Id": "sha256:2a51bb06dc8baa17b4d78b7ca0d87f5aadbd98d711817dbbf2cfe49211556c30",
        "RepoTags": [
            "apache:latest",
            "docker.io/httpd:latest"
        ],
        "RepoDigests": [
            "docker.io/httpd@sha256:9753aabc6b0b8cd0a39733ec13b7aad59e51069ce96d63c6617746272752738e"
        ],
        "Parent": "",
        "Comment": "",
        "Created": "2018-11-15T23:54:07.293451834Z",
        "Container": "e9770766dd74ed26f3ca812c254f847f6c99a9be5258313f656fcb0ae574664a",
        "ContainerConfig": {
            "Hostname": "e9770766dd74",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "80/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/apache2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "HTTPD_PREFIX=/usr/local/apache2",
                "HTTPD_VERSION=2.4.37",
                "HTTPD_SHA256=3498dc5c6772fac2eb7307dc7963122ffe243b5e806e0be4fb51974ff759d726",
                "HTTPD_PATCHES=",
                "APACHE_DIST_URLS=https://www.apache.org/dyn/closer.cgi?action=download&filename= \thttps://www-us.apache.org/dist/ \thttps://www.apache.org/dist/ \thttps://archive.apache.org/dist/"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "CMD [\"httpd-foreground\"]"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:402fe5d365d69f1eff38852f3bc318d8f1e2e3f823639e9a3a56eddc9740338f",
            "Volumes": null,
            "WorkingDir": "/usr/local/apache2",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": {}
        },
        "DockerVersion": "17.06.2-ce",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "80/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/apache2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "HTTPD_PREFIX=/usr/local/apache2",
                "HTTPD_VERSION=2.4.37",
                "HTTPD_SHA256=3498dc5c6772fac2eb7307dc7963122ffe243b5e806e0be4fb51974ff759d726",
                "HTTPD_PATCHES=",
                "APACHE_DIST_URLS=https://www.apache.org/dyn/closer.cgi?action=download&filename= \thttps://www-us.apache.org/dist/ \thttps://www.apache.org/dist/ \thttps://archive.apache.org/dist/"
            ],
            "Cmd": [
                "httpd-foreground"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:402fe5d365d69f1eff38852f3bc318d8f1e2e3f823639e9a3a56eddc9740338f",
            "Volumes": null,
            "WorkingDir": "/usr/local/apache2",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": null
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 131651141,
        "VirtualSize": 131651141,
        "GraphDriver": {
            "Name": "overlay2",
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/079541c6385f059d768db79d8e8696a1cdb16e6f2900c78377721757c2c836ef/diff:/var/lib/docker/overlay2/634de8e180bf2d52a0e858edca10353c34a10cb18b2d1569afcd377d6fe65530/diff:/var/lib/docker/overlay2/3e448cd1768ff13d1b9dd1c55ccded60716a9b0c58f4291fe8b375b26b281fdd/diff:/var/lib/docker/overlay2/d380e9df243a0883fe04d453f6f901a26b2de4cd6c4b83734ef6b22cd1234e00/diff",
                "MergedDir": "/var/lib/docker/overlay2/ae68f49495f6b1477c8a580fb3d857d2c5edded9b3c174c23ae57d2f7caba594/merged",
                "UpperDir": "/var/lib/docker/overlay2/ae68f49495f6b1477c8a580fb3d857d2c5edded9b3c174c23ae57d2f7caba594/diff",
                "WorkDir": "/var/lib/docker/overlay2/ae68f49495f6b1477c8a580fb3d857d2c5edded9b3c174c23ae57d2f7caba594/work"
            }
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:ef68f6734aa485edf13a8509fe60e4272428deaf63f446a441b79d47fc5d17d3",
                "sha256:143e72edeb6dcc7bd2c4d087650b48fda940e5f87c6e8c4e42232ff1303bb5bc",
                "sha256:920e7ca5de494dc444dfb420a73424aff2d63bd74ca24a825aa5f276248111e9",
                "sha256:de926190eb0bb7a3c66ba3063ca385dea11354150720486983ca39e95f26217b",
                "sha256:026f9bea4fc4475616d3679d71fb644be4ca071bfdd23244752db04c6941ed43"
            ]
        }
    }
]
```

- Display environment variables for the httpd image

```
[vagrant@node1 ~]$ docker inspect httpd -f "{{.ContainerConfig.Env}}"
[PATH=/usr/local/apache2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin HTTPD_PREFIX=/usr/local/apache2 HTTPD_VERSION=2.4.37 HTTPD_SHA256=3498dc5c6772fac2eb7307dc7963122ffe243b5e806e0be4fb51974ff759d726 HTTPD_PATCHES= APACHE_DIST_URLS=https://www.apache.org/dyn/closer.cgi?action=download&filename= 	https://www-us.apache.org/dist/ 	https://www.apache.org/dist/ 	https://archive.apache.org/dist/]
```

- Try to improve output


## Removing and untagging images

- Check the "docker-rmi" man page

```
man docker-rmi
```

- Display local images

```
[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
apache              latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
apache              v2.2                e06c3dbbfe23        10 months ago       171 MB
docker.io/httpd     2.2                 e06c3dbbfe23        10 months ago       171 MB
```

- Make sure that image IDs are the same for docker.io/httpd:2.2 and apache:v2.2 images

- Untag the image "apache:v2.2". Make sure that image has been untagged

```
[vagrant@node1 ~]$ docker rmi  apache:v2.2
Untagged: apache:v2.2
Untagged: docker.io/httpd@sha256:9784d70c8ea466fabd52b0bc8cde84980324f9612380d22fbad2151df9a430eb

[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
apache              latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     2.2                 e06c3dbbfe23        10 months ago       171 MB
```


- Delete image docker.io/httpd:2.2 and make sure that all image layer have been deleted

```
[vagrant@node1 ~]$ docker rmi docker.io/httpd:2.2
doUntagged: docker.io/httpd:2.2
Deleted: sha256:e06c3dbbfe239c6fca50b6ab6935b3122930fa2eea2136979e5b46ad77ecb685
Deleted: sha256:aefd81e57d336a46bb1eb4c4626a3f971759e0e9651e348d5e83b301614b4522
Deleted: sha256:b85fe9130aef01e870e6d0a108fd003cf803d5da7fe479513a21de0643d7ecae
Deleted: sha256:40154da5ddb3570d82395b9c632880baca5f12ad21ea8c699f3897cd5ed9b237
Deleted: sha256:f5863aa45770c31d7555287f821930e41bc466b97464733ccf980f16393d99d9
Deleted: sha256:4bcdffd70da292293d059d2435c7056711fab2655f8b74f48ad0abe042b63687



[vagrant@node1 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
apache              latest              2a51bb06dc8b        2 weeks ago         132 MB
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
```

- Untag the "apache:latest" image
