# Lab10 - Creating new images by docker commit

## docker commit
- Check the "docker-commit" man page

```
man docker-commit
```

## Creating an Apache image
- Start a new container and install and configure httpd

```
docker run -it centos:7 /bin/bash -c 'yum install -y httpd; yum clean all; echo "Custom Image" >/var/www/html/index.html'
```
- Make sure that container is stopped
```
[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS               NAMES
d89efebc98e5        centos:7            "/bin/bash -c 'yum..."   44 seconds ago      Exited (0) 7 seconds ago                       modest_ptolemy
```

- "Convert" container to a docker images by using "docker commit"

```
[vagrant@node1 ~]$ docker commit -c "CMD /usr/sbin/httpd -DFOREGROUND" d89efebc98e5 myhttpd
sha256:82656d2150f8676a87875858608ada30fd5a478f79f7a9fc9cd5a999edf24dd9

[vagrant@node1 learn-docker]$ docker images myhttpd
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
myhttpd             latest              82656d2150f8        6 seconds ago       255 MB
```

- start a new container from the image
```
docker run -d --name httpd -p8080:80  myhttpd
```

- Make sure that image works

```
[vagrant@node1 lab10-docker-commit]$ docker run -d --name httpd -p8080:80  myhttpd
ccaa1ec03eb2b5335e68b6b3902057680c3d859e85a98766647b0805cea80148

[vagrant@node1 lab10-docker-commit]$ docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd
172.17.0.2
[vagrant@node1 lab10-docker-commit]$ curl 172.17.0.2
Custom Image
```

- Delete all containers

```
docker rm -f $(docker ps -aq)
```
