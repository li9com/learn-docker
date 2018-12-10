# Lab7 - Using persistent storage
In this lab, you will start Docker containers on a persistent storage.

## Apache service
In this lab chapter, we will be using another Apache Docker image, which is OpenShift-ready.
The image name is httpd-24-centos7

- Pull docker.io/centos/httpd-24-centos7 Docker image

```
docker pull docker.io/centos/httpd-24-centos7
```

- Start an httpd container to make sure that it works

```
[vagrant@node1 ~]$ docker run -d --name httpd -p 8080:8080 docker.io/centos/httpd-24-centos7
5993f43525167b6c6f109aed098666239dfa78b8a8553b43a88eec2c9f6d5c1e


[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE                               COMMAND                  CREATED             STATUS              PORTS                              NAMES
5993f4352516        docker.io/centos/httpd-24-centos7   "container-entrypo..."   2 seconds ago       Up 1 second         0.0.0.0:8080->8080/tcp, 8443/tcp   httpd
```

- Try to access your application using Web Browser
http://node1.172.24.0.11.nip.io:8080
http://172.24.0.11:8080

You should be able to see "Red Hat Enterprise Linux Test Page"
This page has been displayed, since there is no index.html

- Delete the container

```
docker rm -f $(docker ps -aq)
```

- Inspect the image docker.io/centos/httpd-24-centos7. We need to understand which storage is used

```
[vagrant@node1 ~]$ docker inspect docker.io/centos/httpd-24-centos7 | jq '.'
[
    {
        "Id": "sha256:a562f884ddeae2ddbca6d9e91fe8deac946589263010b036aa46df1d6ceef7b8",
        "RepoTags": [
            "docker.io/centos/httpd-24-centos7:latest"
        ],
        "RepoDigests": [
            "docker.io/centos/httpd-24-centos7@sha256:a67bb9760f6eb06b3a7f19a6908cc594830bc1a12360ddd0f14168ace689e1d6"
        ],
        "Parent": "",
        "Comment": "",
        "Created": "2018-10-26T07:16:39.363817425Z",
        "Container": "362a0a93da34d13fc8ea7c0dd5e578492a651009ee3d8065f0f7b8c9d7244f1f",
        "ContainerConfig": {
            "Hostname": "4a39b7ce238c",
            "Domainname": "",
            "User": "1001",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "8080/tcp": {},
                "8443/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "SUMMARY=Platform for running Apache httpd 2.4 or building httpd-based application",
                "DESCRIPTION=Apache httpd 2.4 available as container, is a powerful, efficient, and extensible web server. Apache supports a variety of features, many implemented as compiled modules which extend the core functionality. These can range from server-side programming language support to authentication schemes. Virtual hosting allows one Apache installation to serve many different Web sites.",
                "STI_SCRIPTS_URL=image:///usr/libexec/s2i",
                "STI_SCRIPTS_PATH=/usr/libexec/s2i",
                "APP_ROOT=/opt/app-root",
                "HOME=/opt/app-root/src",
                "BASH_ENV=/opt/app-root/scl_enable",
                "ENV=/opt/app-root/scl_enable",
                "PROMPT_COMMAND=. /opt/app-root/scl_enable",
                "HTTPD_VERSION=2.4",
                "HTTPD_CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/httpd/",
                "HTTPD_APP_ROOT=/opt/app-root",
                "HTTPD_CONFIGURATION_PATH=/opt/app-root/etc/httpd.d",
                "HTTPD_MAIN_CONF_PATH=/etc/httpd/conf",
                "HTTPD_MAIN_CONF_MODULES_D_PATH=/etc/httpd/conf.modules.d",
                "HTTPD_MAIN_CONF_D_PATH=/etc/httpd/conf.d",
                "HTTPD_VAR_RUN=/var/run/httpd",
                "HTTPD_DATA_PATH=/var/www",
                "HTTPD_DATA_ORIG_PATH=/opt/rh/httpd24/root/var/www",
                "HTTPD_LOG_PATH=/var/log/httpd24",
                "HTTPD_SCL=httpd24"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "LABEL io.openshift.builder-version=\"2ff6212\""
            ],
            "ArgsEscaped": true,
            "Image": "sha256:42df27e3c75e3e81e35e04898b14ab8e12a0b23c733d230f0601602a0f41b5a0",
            "Volumes": null,
            "WorkingDir": "/opt/app-root/src",
            "Entrypoint": [
                "container-entrypoint"
            ],
            "OnBuild": [],
            "Labels": {
                "com.redhat.component": "httpd24-container",
                "description": "Apache httpd 2.4 available as container, is a powerful, efficient, and extensible web server. Apache supports a variety of features, many implemented as compiled modules which extend the core functionality. These can range from server-side programming language support to authentication schemes. Virtual hosting allows one Apache installation to serve many different Web sites.",
                "io.k8s.description": "Apache httpd 2.4 available as container, is a powerful, efficient, and extensible web server. Apache supports a variety of features, many implemented as compiled modules which extend the core functionality. These can range from server-side programming language support to authentication schemes. Virtual hosting allows one Apache installation to serve many different Web sites.",
                "io.k8s.display-name": "Apache httpd 2.4",
                "io.openshift.builder-version": "\"2ff6212\"",
                "io.openshift.expose-services": "8080:http,8443:https",
                "io.openshift.s2i.scripts-url": "image:///usr/libexec/s2i",
                "io.openshift.tags": "builder,httpd,httpd24",
                "io.s2i.scripts-url": "image:///usr/libexec/s2i",
                "maintainer": "SoftwareCollections.org <sclorg@redhat.com>",
                "name": "centos/httpd-24-centos7",
                "org.label-schema.build-date": "20181006",
                "org.label-schema.license": "GPLv2",
                "org.label-schema.name": "CentOS Base Image",
                "org.label-schema.schema-version": "1.0",
                "org.label-schema.vendor": "CentOS",
                "release": "1",
                "summary": "Platform for running Apache httpd 2.4 or building httpd-based application",
                "usage": "s2i build https://github.com/sclorg/httpd-container.git --context-dir=examples/sample-test-app/ centos/httpd-24-centos7 sample-server",
                "version": "2.4"
            }
        },
        "DockerVersion": "1.13.1",
        "Author": "",
        "Config": {
            "Hostname": "4a39b7ce238c",
            "Domainname": "",
            "User": "1001",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "8080/tcp": {},
                "8443/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/opt/app-root/src/bin:/opt/app-root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "SUMMARY=Platform for running Apache httpd 2.4 or building httpd-based application",
                "DESCRIPTION=Apache httpd 2.4 available as container, is a powerful, efficient, and extensible web server. Apache supports a variety of features, many implemented as compiled modules which extend the core functionality. These can range from server-side programming language support to authentication schemes. Virtual hosting allows one Apache installation to serve many different Web sites.",
                "STI_SCRIPTS_URL=image:///usr/libexec/s2i",
                "STI_SCRIPTS_PATH=/usr/libexec/s2i",
                "APP_ROOT=/opt/app-root",
                "HOME=/opt/app-root/src",
                "BASH_ENV=/opt/app-root/scl_enable",
                "ENV=/opt/app-root/scl_enable",
                "PROMPT_COMMAND=. /opt/app-root/scl_enable",
                "HTTPD_VERSION=2.4",
                "HTTPD_CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/httpd/",
                "HTTPD_APP_ROOT=/opt/app-root",
                "HTTPD_CONFIGURATION_PATH=/opt/app-root/etc/httpd.d",
                "HTTPD_MAIN_CONF_PATH=/etc/httpd/conf",
                "HTTPD_MAIN_CONF_MODULES_D_PATH=/etc/httpd/conf.modules.d",
                "HTTPD_MAIN_CONF_D_PATH=/etc/httpd/conf.d",
                "HTTPD_VAR_RUN=/var/run/httpd",
                "HTTPD_DATA_PATH=/var/www",
                "HTTPD_DATA_ORIG_PATH=/opt/rh/httpd24/root/var/www",
                "HTTPD_LOG_PATH=/var/log/httpd24",
                "HTTPD_SCL=httpd24"
            ],
            "Cmd": [
                "/usr/bin/run-httpd"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:42df27e3c75e3e81e35e04898b14ab8e12a0b23c733d230f0601602a0f41b5a0",
            "Volumes": null,
            "WorkingDir": "/opt/app-root/src",
            "Entrypoint": [
                "container-entrypoint"
            ],
            "OnBuild": [],
            "Labels": {
                "com.redhat.component": "httpd24-container",
                "description": "Apache httpd 2.4 available as container, is a powerful, efficient, and extensible web server. Apache supports a variety of features, many implemented as compiled modules which extend the core functionality. These can range from server-side programming language support to authentication schemes. Virtual hosting allows one Apache installation to serve many different Web sites.",
                "io.k8s.description": "Apache httpd 2.4 available as container, is a powerful, efficient, and extensible web server. Apache supports a variety of features, many implemented as compiled modules which extend the core functionality. These can range from server-side programming language support to authentication schemes. Virtual hosting allows one Apache installation to serve many different Web sites.",
                "io.k8s.display-name": "Apache httpd 2.4",
                "io.openshift.builder-version": "\"2ff6212\"",
                "io.openshift.expose-services": "8080:http,8443:https",
                "io.openshift.s2i.scripts-url": "image:///usr/libexec/s2i",
                "io.openshift.tags": "builder,httpd,httpd24",
                "io.s2i.scripts-url": "image:///usr/libexec/s2i",
                "maintainer": "SoftwareCollections.org <sclorg@redhat.com>",
                "name": "centos/httpd-24-centos7",
                "org.label-schema.build-date": "20181006",
                "org.label-schema.license": "GPLv2",
                "org.label-schema.name": "CentOS Base Image",
                "org.label-schema.schema-version": "1.0",
                "org.label-schema.vendor": "CentOS",
                "release": "1",
                "summary": "Platform for running Apache httpd 2.4 or building httpd-based application",
                "usage": "s2i build https://github.com/sclorg/httpd-container.git --context-dir=examples/sample-test-app/ centos/httpd-24-centos7 sample-server",
                "version": "2.4"
            }
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 355550941,
        "VirtualSize": 355550941,
        "GraphDriver": {
            "Name": "overlay2",
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/b473179c063e27d0808abf07b5db707e93abd30f21569b535d2ab648ac54e7d7/diff:/var/lib/docker/overlay2/4271f9e9edf06fc93a10ab4feb177b4432babb8a4ccda8c998b8489cf4e9b984/diff:/var/lib/docker/overlay2/90fcb3db9d9907cf8a5c83d3654a5c50a6ec804819a8212a9f8403f98b5f6366/diff:/var/lib/docker/overlay2/0718fb57314751d0f97dec3a9d69ca8ddd498ce018978047b16b2b1190934d9b/diff:/var/lib/docker/overlay2/dcbff9129a79e3e87147a9123f41ecf416e0a358dd06f4c60a22b7f548f34ff3/diff:/var/lib/docker/overlay2/366154ec5abfdf5f07586708eee21d26cbaca0ed8bae950c4b0eeea5c8b535f8/diff:/var/lib/docker/overlay2/75bb41391a26eac75d776432bd7ccea9e50281ce2a7ffbc2df6926ea0e7c641c/diff",
                "MergedDir": "/var/lib/docker/overlay2/e49d42945634adac00bcda9d451080191b8ad6c940340d9f8dfd90de270b83f8/merged",
                "UpperDir": "/var/lib/docker/overlay2/e49d42945634adac00bcda9d451080191b8ad6c940340d9f8dfd90de270b83f8/diff",
                "WorkDir": "/var/lib/docker/overlay2/e49d42945634adac00bcda9d451080191b8ad6c940340d9f8dfd90de270b83f8/work"
            }
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:f972d139738dfcd1519fd2461815651336ee25a8b54c358834c50af094bb262f",
                "sha256:84293cc95fdf32ce2a2f477f02c32f035173211a15ddc6e96f9f0accf949c39b",
                "sha256:0bb055614aecb2ad6b25843facbfebc068c9b4cadc7de7b5a61925535abc9e0a",
                "sha256:20a61b68701f40c22ae5e1a683ebfc0a4c67379a0f2675f862d6f3b144c73eda",
                "sha256:2f3360f0a405b6e27e48535a3a04193be5d936e10945b6e2633fa6bfb7fa6df0",
                "sha256:961fecff3b4390a415a10c33361e6ce3f46b45f2a48dddfcd8a55e73e81b55ad",
                "sha256:83f7c390e4044165744a2ec5be9c9f2d3d9b70ff6d9930ae49abdca96437906f",
                "sha256:fd1933f7de5909cba41d1291a8f0907be336479857548aaaf36f947803646f32"
            ]
        }
    }
]
```

Note! The *HTTPD_DATA_PATH* variable points to */var/www* directory. It looks like persistent storage should be under standard RHEL Apache directory */var/www/html*.

- Create a persistent storage for Apache container

```
sudo mkdir -p /data/apache
sudo chcon -t container_file_t /data/apache
sudo chown 1001:0 /data/apache
sudo chmod g+s /data/apache
sudo sh -c 'echo "Custom page" > /data/apache/index.html'
```

Note! We have created a custom directory with index.html file in it. We will mount this directory into the new apache containers on start.

- Start 3 apache containers using persistent strage

```
[vagrant@node1 ~]$ docker run -d --name httpd1 -p 8081:8080 -v /data/apache:/var/www/html docker.io/centos/httpd-24-centos7
8bc976f8b87e5a3baa9172213484ae67aacb91969a27c6546d73f2e5cc7fe17c
[vagrant@node1 ~]$ docker run -d --name httpd2 -p 8082:8080 -v /data/apache:/var/www/html docker.io/centos/httpd-24-centos7
6775f62d2d3522319daece1c755f3149ffbb7b370aae46082f2fcc2746728144
[vagrant@node1 ~]$ docker run -d --name httpd3 -p 8083:8080 -v /data/apache:/var/www/html docker.io/centos/httpd-24-centos7
716b7e300aaa7240b5d12766a483164e146cdbc885a4fc23546d3ded48700c54
```

- Make sure that all containers return the same data

Gather container information

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE                               COMMAND                  CREATED             STATUS              PORTS                              NAMES
716b7e300aaa        docker.io/centos/httpd-24-centos7   "container-entrypo..."   3 seconds ago       Up 2 seconds        8443/tcp, 0.0.0.0:8083->8080/tcp   httpd3
6775f62d2d35        docker.io/centos/httpd-24-centos7   "container-entrypo..."   12 seconds ago      Up 11 seconds       8443/tcp, 0.0.0.0:8082->8080/tcp   httpd2
8bc976f8b87e        docker.io/centos/httpd-24-centos7   "container-entrypo..."   22 seconds ago      Up 21 seconds       8443/tcp, 0.0.0.0:8081->8080/tcp   httpd1
```

Gather IP addresses and access apache web services

```
[vagrant@node1 ~]$ curl http://$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd1):8080
Custom page
[vagrant@node1 ~]$ curl http://$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd2):8080
Custom page
[vagrant@node1 ~]$ curl http://$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd3):8080
Custom page
```

All services should return the same data

- Update index.html and make sure that the returned content has changed

```
[vagrant@node1 ~]$ sudo sh -c 'echo "New line" >> /data/apache/index.html'
[vagrant@node1 ~]$ curl http://$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd1):8080
Custom page
New line
[vagrant@node1 ~]$ curl http://$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd2):8080
Custom page
New line
[vagrant@node1 ~]$ curl http://$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd3):8080
Custom page
New line
```

- Remove all containers

```
docker rm -f $(docker ps -aq)
```

## Persistent MariaDB


- Check location of MariaDB data volume

```
[vagrant@node1 learn-docker]$ docker inspect --format='{{ .Config.Volumes }}' mariadb
map[/var/lib/mysql:{}]
```

Note! It looks like /var/lib/mysql should be used for the persistent storage.

- Configure mariadb persistent storage

```
sudo mkdir -p /data/mysql
sudo chcon -t container_file_t /data/mysql
```

- Start a mariadb container

```
docker run -d --name mariadb \
   -v /data/mysql:/var/lib/mysql \
   -e MYSQL_ROOT_PASSWORD=secret \
   -e MYSQL_USER=dbuser \
   -e MYSQL_PASSWORD=dbpassword \
   -e MYSQL_DATABASE=exampledb \
   mariadb
```

- Check the status

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
b23db07b10e8        mariadb             "docker-entrypoint..."   2 seconds ago       Up 1 second         3306/tcp            mariadb
```

- Make sure that service works

```
[vagrant@node1 ~]$ docker exec -it mariadb mysql -udbuser -pdbpassword -h127.0.0.1 -e 'show databases;' exampledb
+--------------------+
| Database           |
+--------------------+
| exampledb          |
| information_schema |
+--------------------+
```

- Make sure that files are stored on the persistent storage

```
[vagrant@node1 ~]$ ls -ln /data/mysql/
total 122940
-rw-rw----. 1 999 999    16384 Dec  4 07:21 aria_log.00000001
-rw-rw----. 1 999 999       52 Dec  4 07:21 aria_log_control
drwx------. 2 999 999     4096 Dec  4 07:21 exampledb
-rw-rw----. 1 999 999      976 Dec  4 07:21 ib_buffer_pool
-rw-rw----. 1 999 999 12582912 Dec  4 07:21 ibdata1
-rw-rw----. 1 999 999 50331648 Dec  4 07:21 ib_logfile0
-rw-rw----. 1 999 999 50331648 Dec  4 07:21 ib_logfile1
-rw-rw----. 1 999 999 12582912 Dec  4 07:21 ibtmp1
-rw-rw----. 1 999 999        0 Dec  4 07:21 multi-master.info
drwx------. 2 999 999     4096 Dec  4 07:21 mysql
drwx------. 2 999 999     4096 Dec  4 07:21 performance_schema
-rw-rw----. 1 999 999    24576 Dec  4 07:21 tc.log
```

- Delete the container and start a new one using the same persistent storage

There is no need to provide environment variables again to create a database and user, since we are re-using the same directory with database data in it.

```
docker rm -f mariadb
docker run -d --name mariadb -v /data/mysql:/var/lib/mysql mariadb
```

- Confirm that new container is running and we still have *exampledb* database.

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
793577d26bb5        mariadb             "docker-entrypoint..."   1 second ago        Up 1 second         3306/tcp            mariadb
[vagrant@node1 ~]$ docker exec -it mariadb mysql -udbuser -pdbpassword -h127.0.0.1 -e 'show databases;' exampledb
+--------------------+
| Database           |
+--------------------+
| exampledb          |
| information_schema |
+--------------------+
```

- Delete all containers

```
docker rm -f $(docker ps -aq)
```
