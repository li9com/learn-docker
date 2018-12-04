# Lab5 - Managing containers
This document guide you on how to manage Docker containers via the "docker" utility.
This includes:
- Starting containers
- Stopping containers
- Deleting containers
- Listing running and stopped containers
- Gathering container details
- Exposing containers


## Starting new containers
- Check the "docker-run" man page

```
man docker-run
```

- Chech the docker run --help

```
docker run --help
```

- Start the basic httpd container with no options:

```
[vagrant@node1 ~]$ docker run httpd
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
[Tue Dec 04 01:26:58.059258 2018] [mpm_event:notice] [pid 1:tid 140240398247104] AH00489: Apache/2.4.37 (Unix) configured -- resuming normal operations
[Tue Dec 04 01:26:58.059469 2018] [core:notice] [pid 1:tid 140240398247104] AH00094: Command line: 'httpd -D FOREGROUND'

^C[Tue Dec 04 01:27:01.856785 2018] [mpm_event:notice] [pid 1:tid 140240398247104] AH00491: caught SIGTERM, shutting down
```

Note! The container shows output to the screen
Note! You need to stop container using "CTRL + C"

- Make sure that container is not up and running

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED              STATUS                          PORTS               NAMES
33f8a4d3b6e5        httpd               "httpd-foreground"   About a minute ago   Exited (0) About a minute ago                       sleepy_bassi
```

Note! the "docker ps -a" shows status of all contianers including stopped

- Start a new httpd container in background:

```
[vagrant@node1 ~]$ docker run -d httpd
e22a2da30a1f6674e61db28a98785375c7b36fc9b8bbff439dbb3747ef605006
```

- Make sure that container is up and running. Check the conainer name

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   29 seconds ago      Up 29 seconds       80/tcp              hungry_gates

[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED              STATUS                     PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   About a minute ago   Up About a minute          80/tcp              hungry_gates
33f8a4d3b6e5        httpd               "httpd-foreground"   4 minutes ago        Exited (0) 4 minutes ago                       sleepy_bassi
```

- Start a temporary httpd container and terminate it by "CTRL + C"

```
[vagrant@node1 ~]$ docker run --rm httpd
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.3. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.3. Set the 'ServerName' directive globally to suppress this message
[Tue Dec 04 01:32:10.279690 2018] [mpm_event:notice] [pid 1:tid 140097812133056] AH00489: Apache/2.4.37 (Unix) configured -- resuming normal operations
[Tue Dec 04 01:32:10.279964 2018] [core:notice] [pid 1:tid 140097812133056] AH00094: Command line: 'httpd -D FOREGROUND'
^C[Tue Dec 04 01:32:11.710417 2018] [mpm_event:notice] [pid 1:tid 140097812133056] AH00491: caught SIGTERM, shutting down
```

- Make sure that container has been deleted automatically

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   2 minutes ago       Up 2 minutes        80/tcp              hungry_gates
[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                     PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   2 minutes ago       Up 2 minutes               80/tcp              hungry_gates
33f8a4d3b6e5        httpd               "httpd-foreground"   5 minutes ago       Exited (0) 5 minutes ago                       sleepy_bassi
```

Note! You should not see any new containers

## Stopping/starting existing containers
- Check the man pages for "docker-stop" and "docker-start"

- Check the running containers

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   3 minutes ago       Up 3 minutes        80/tcp              hungry_gates
```

- Stop a running container

```
[vagrant@node1 ~]$ docker stop e22a2da30a1f
e22a2da30a1f
```

Note!  You may use container ID or container name. It is up to you. We could stop the container as follows:

```
docker stop hungry_gates
```

- Make sure that container was stoped

````
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES


[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                     PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   4 minutes ago       Exited (0) 5 seconds ago                       hungry_gates
33f8a4d3b6e5        httpd               "httpd-foreground"   7 minutes ago       Exited (0) 7 minutes ago                       sleepy_bassi
```

Note! "docker ps" should not show the container you stopped

- Start the container again

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                      PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   8 minutes ago       Exited (0) 4 minutes ago                        hungry_gates
33f8a4d3b6e5        httpd               "httpd-foreground"   11 minutes ago      Exited (0) 11 minutes ago                       sleepy_bassi

[vagrant@node1 ~]$ docker start hungry_gates
hungry_gates
```

Note! We have used conainer name instead of container id.

- Make sure that container is up and running

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
e22a2da30a1f        httpd               "httpd-foreground"   8 minutes ago       Up 1 second         80/tcp              hungry_gates
```

- Start a container with custom name

```
[vagrant@node1 ~]$ docker run -d --name my_custom_name httpd
0fc05b1bb9c4e325aa1923220ce34125ae4771be42419c153d7f04b14c1c490a

```
- Make sure that container was named properly (my_custom_name)

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
0fc05b1bb9c4        httpd               "httpd-foreground"   2 seconds ago       Up 1 second         80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   13 minutes ago      Up 4 minutes        80/tcp              hungry_gates
```

- Start a new container with another name. Make sure that name is properly shown

```
[vagrant@node1 ~]$ docker run -d --name it_works_container httpd
c10f2a6e7b253323665c8f11cba3b8281c13b5a0577c0809b3acc7ee0154ef23

[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED              STATUS              PORTS               NAMES
c10f2a6e7b25        httpd               "httpd-foreground"   4 seconds ago        Up 3 seconds        80/tcp              it_works_container
0fc05b1bb9c4        httpd               "httpd-foreground"   About a minute ago   Up About a minute   80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   14 minutes ago       Up 5 minutes        80/tcp              hungry_gates
```


## Listing running and stopped containers
Note! We already used "docker ps" to list running and stopped containers. In this chapter we will learn how to use advanced docker ps functionallity.

- Check the "docker-ps" man page

```
man docker-ps
```

- Display running and stopped containers:

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
c10f2a6e7b25        httpd               "httpd-foreground"   57 seconds ago      Up 56 seconds       80/tcp              it_works_container
0fc05b1bb9c4        httpd               "httpd-foreground"   2 minutes ago       Up 2 minutes        80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   15 minutes ago      Up 6 minutes        80/tcp              hungry_gates


[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                      PORTS               NAMES
c10f2a6e7b25        httpd               "httpd-foreground"   59 seconds ago      Up 58 seconds               80/tcp              it_works_container
0fc05b1bb9c4        httpd               "httpd-foreground"   2 minutes ago       Up 2 minutes                80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   15 minutes ago      Up 6 minutes                80/tcp              hungry_gates
33f8a4d3b6e5        httpd               "httpd-foreground"   18 minutes ago      Exited (0) 18 minutes ago                       sleepy_bassi
```

- Display container IDs only

```
[vagrant@node1 ~]$ docker ps -aq
c10f2a6e7b25
0fc05b1bb9c4
e22a2da30a1f
33f8a4d3b6e5
```

Note! We will be using this command a lot in the next labs

- Apply an output filter using -f option

```
[vagrant@node1 ~]$ docker ps -f status=exited
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                      PORTS               NAMES
33f8a4d3b6e5        httpd               "httpd-foreground"   21 minutes ago      Exited (0) 21 minutes ago                       sleepy_bassi
```

- Apply output format using --format option

```
[vagrant@node1 ~]$ docker ps --format="{{.ID}}\t{{.Image}}"
c10f2a6e7b25	httpd
0fc05b1bb9c4	httpd
e22a2da30a1f	httpd
```

## Gathering container details



## Exposing containers

