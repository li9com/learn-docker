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

```
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

- Check the "docker-inspecr" man page

```
man docker-inspect
```

- Start a new container named myhttpd

```
[vagrant@node1 learn-docker]$ docker run -d --name myhttpd httpd
49fc9eb92d3d3802c62b2218197b8e375b6c56457ad4337d66590d861b282a64
```

- Inspect container details using "docker inspect"

```
[vagrant@node1 ~]$ docker inspect myhttpd
[
    {
        "Id": "49fc9eb92d3d3802c62b2218197b8e375b6c56457ad4337d66590d861b282a64",
        "Created": "2018-12-04T02:51:07.463795846Z",
        "Path": "httpd-foreground",
        "Args": [],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 29514,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2018-12-04T02:51:07.781316387Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:2a51bb06dc8baa17b4d78b7ca0d87f5aadbd98d711817dbbf2cfe49211556c30",
        "ResolvConfPath": "/var/lib/docker/containers/49fc9eb92d3d3802c62b2218197b8e375b6c56457ad4337d66590d861b282a64/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/49fc9eb92d3d3802c62b2218197b8e375b6c56457ad4337d66590d861b282a64/hostname",
        "HostsPath": "/var/lib/docker/containers/49fc9eb92d3d3802c62b2218197b8e375b6c56457ad4337d66590d861b282a64/hosts",
        "LogPath": "",
        "Name": "/myhttpd",
        "RestartCount": 0,
        "Driver": "overlay2",
        "MountLabel": "system_u:object_r:svirt_sandbox_file_t:s0:c516,c811",
        "ProcessLabel": "system_u:system_r:svirt_lxc_net_t:s0:c516,c811",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "journald",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {},
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "docker-runc",
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": null,
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DiskQuota": 0,
            "KernelMemory": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": -1,
            "OomKillDisable": false,
            "PidsLimit": 0,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0
        },
        "GraphDriver": {
            "Name": "overlay2",
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/cf9efb4e21f3dca86311f31b202bc709aa5dd1c9d22dec9d859fa12eb919f5e8-init/diff:/var/lib/docker/overlay2/ae68f49495f6b1477c8a580fb3d857d2c5edded9b3c174c23ae57d2f7caba594/diff:/var/lib/docker/overlay2/079541c6385f059d768db79d8e8696a1cdb16e6f2900c78377721757c2c836ef/diff:/var/lib/docker/overlay2/634de8e180bf2d52a0e858edca10353c34a10cb18b2d1569afcd377d6fe65530/diff:/var/lib/docker/overlay2/3e448cd1768ff13d1b9dd1c55ccded60716a9b0c58f4291fe8b375b26b281fdd/diff:/var/lib/docker/overlay2/d380e9df243a0883fe04d453f6f901a26b2de4cd6c4b83734ef6b22cd1234e00/diff",
                "MergedDir": "/var/lib/docker/overlay2/cf9efb4e21f3dca86311f31b202bc709aa5dd1c9d22dec9d859fa12eb919f5e8/merged",
                "UpperDir": "/var/lib/docker/overlay2/cf9efb4e21f3dca86311f31b202bc709aa5dd1c9d22dec9d859fa12eb919f5e8/diff",
                "WorkDir": "/var/lib/docker/overlay2/cf9efb4e21f3dca86311f31b202bc709aa5dd1c9d22dec9d859fa12eb919f5e8/work"
            }
        },
        "Mounts": [],
        "Config": {
            "Hostname": "49fc9eb92d3d",
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
            "Image": "httpd",
            "Volumes": null,
            "WorkingDir": "/usr/local/apache2",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "9a42c357bb63df5a98de2ce218fb62b89cf845f3ed61cfdac57c7621d7731880",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "80/tcp": null
            },
            "SandboxKey": "/var/run/docker/netns/9a42c357bb63",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "c74ad7358d6d94de0d1c01b914f4ce5cbc953b72f126e018693c321d7e7e87b5",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.5",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:05",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "5aab0cda8cae26003f2dddc79bd219fc0bf117e18ecae54cc9d7cbc8bfb878d0",
                    "EndpointID": "c74ad7358d6d94de0d1c01b914f4ce5cbc953b72f126e018693c321d7e7e87b5",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.5",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:05"
                }
            }
        }
    }
]
```

- Customize docker inspect output to show IP Address only

```
[vagrant@node1 ~]$ docker inspect --format '{{.NetworkSettings.IPAddress}}' myhttpd
172.17.0.5
```

- Customize output to gather container network ports

```
[vagrant@node1 ~]$ docker inspect --format '{{.NetworkSettings.Ports}}' myhttpd
map[80/tcp:[]]
```

- Try to access containerized application

```
[vagrant@node1 ~]$ curl  http://172.17.0.5
<html><body><h1>It works!</h1></body></html>
```

Note! We started a httpd container which is Apache web server. It is expected that the application answer is "It works"


## Deleting containers

- Check the "dicker-rm" man page

```
man docker-rm
```

Note! By default, the "docker rm" command deletes only stopped containers. If you need to delete a running container, option "-f" is required.

- Try to delete stopped conainers

```
[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                         PORTS               NAMES
49fc9eb92d3d        httpd               "httpd-foreground"   30 minutes ago      Up 30 minutes                  80/tcp              myhttpd
c10f2a6e7b25        httpd               "httpd-foreground"   About an hour ago   Up About an hour               80/tcp              it_works_container
0fc05b1bb9c4        httpd               "httpd-foreground"   About an hour ago   Up About an hour               80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   About an hour ago   Up About an hour               80/tcp              hungry_gates
33f8a4d3b6e5        httpd               "httpd-foreground"   About an hour ago   Exited (0) About an hour ago                       sleepy_bassi


[vagrant@node1 ~]$ docker rm 33f8a4d3b6e5
33f8a4d3b6e5


[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
49fc9eb92d3d        httpd               "httpd-foreground"   30 minutes ago      Up 30 minutes       80/tcp              myhttpd
c10f2a6e7b25        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              it_works_container
0fc05b1bb9c4        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              hungry_gates
```

- Try to delete a running container

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
49fc9eb92d3d        httpd               "httpd-foreground"   31 minutes ago      Up 31 minutes       80/tcp              myhttpd
c10f2a6e7b25        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              it_works_container
0fc05b1bb9c4        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              hungry_gates

[vagrant@node1 ~]$ docker rm myhttpd
Error response from daemon: You cannot remove a running container 49fc9eb92d3d3802c62b2218197b8e375b6c56457ad4337d66590d861b282a64. Stop the container before attempting removal or use -f
```

- Try again with "-f"

```
[vagrant@node1 ~]$ docker rm -f myhttpd
myhttpd


[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
c10f2a6e7b25        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              it_works_container
0fc05b1bb9c4        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              my_custom_name
e22a2da30a1f        httpd               "httpd-foreground"   About an hour ago   Up About an hour    80/tcp              hungry_gates
```

Note! Container has been succesfully deleted

- Delete all containers

```
[vagrant@node1 ~]$ docker rm -f $(docker ps -aq)
c10f2a6e7b25
0fc05b1bb9c4
e22a2da30a1f
[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[vagrant@node1 ~]$
```

Note! We will use this to clean the system

## Exposing containers

By default, containers use an internal network which is not accessible outside of the Docker node.  Container port may be bound to a Docker node port using "-p" option of the "docker run".

- Check the "docker-run" man page. Look for -p, or "--publish" option

```
man docker-run
```

- Check builtin documentation

```
[vagrant@node1 ~]$ docker run --help|grep publish
  -p, --publish list                          Publish a container's port(s) to the host (default [])
  -P, --publish-all                           Publish all exposed ports to random ports
```

- Start a new httpd container and bind it to port 8080 of the Docker node:

```
[vagrant@node1 ~]$ docker run -d --name httpd -p 8080:80 httpd
67f530ea1da86d655be870c91cedd0646bd037594884686028ce62a89cecc508
```

- Make sure that "docker ps" output show port binding
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
67f530ea1da8        httpd               "httpd-foreground"   1 second ago        Up 1 second         0.0.0.0:8080->80/tcp   httpd
```

- Access containerized application using Node IP address:

```
[vagrant@node1 ~]$ ip a
<OMITTED>
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:1d:b7:b2 brd ff:ff:ff:ff:ff:ff
    inet 172.24.0.11/24 brd 172.24.0.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe1d:b7b2/64 scope link
       valid_lft forever preferred_lft forever
4: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:6b:f1:5e:9b brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:6bff:fef1:5e9b/64 scope link
       valid_lft forever preferred_lft forever
<OMITTED>

[vagrant@node1 ~]$ curl http://127.0.0.1:8080
<html><body><h1>It works!</h1></body></html>

[vagrant@node1 ~]$ curl http://172.24.0.11:8080
<html><body><h1>It works!</h1></body></html>
```

Note! Application is accessible from the Docker Node using its IP addresses.

- Try to start a new httpd container and bind it to the same Docker node port.

```
[vagrant@node1 ~]$ docker run -d --name new_httpd -p 8080:80 httpd
bd43103ece1e307d0f33d0178b5bae69177b5cfeb4b89e446e648dc38b02166b
/usr/bin/docker-current: Error response from daemon: driver failed programming external connectivity on endpoint new_httpd (b9742c948d67ca546db0b78ba7d24cf4507a5b83d3eefb28903d1c6aa948138b): Bind for 0.0.0.0:8080 failed: port is already allocated.
```

Note! it is expected that command show the error

- Check running containers. Make sure that only one container is bound to port 8080 of the Docker node

```
[vagrant@node1 ~]$ docker ps -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
bd43103ece1e        httpd               "httpd-foreground"   49 seconds ago      Created                                    new_httpd
67f530ea1da8        httpd               "httpd-foreground"   3 minutes ago       Up 3 minutes        0.0.0.0:8080->80/tcp   httpd
```

- Delete all containers

```
docker rm -f $(docker ps -aq)
```

- Start a new Jenkins container and bind it to port 8080 of the Docker node

```
[vagrant@node1 ~]$ docker run -d --name jenkins -p 8080:8080 jenkins
Unable to find image 'jenkins:latest' locally
Trying to pull repository docker.io/library/jenkins ...
latest: Pulling from docker.io/library/jenkins
55cbf04beb70: Pull complete
1607093a898c: Pull complete
9a8ea045c926: Pull complete
d4eee24d4dac: Pull complete
c58988e753d7: Pull complete
794a04897db9: Pull complete
70fcfa476f73: Pull complete
0539c80a02be: Pull complete
54fefc6dcf80: Pull complete
911bc90e47a8: Pull complete
38430d93efed: Pull complete
7e46ccda148a: Pull complete
c0cbcb5ac747: Pull complete
35ade7a86a8e: Pull complete
aa433a6a56b1: Pull complete
841c1dd38d62: Pull complete
b865dcb08714: Pull complete
5a3779030005: Pull complete
12b47c68955c: Pull complete
1322ea3e7bfd: Pull complete
Digest: sha256:eeb4850eb65f2d92500e421b430ed1ec58a7ac909e91f518926e02473904f668
Status: Downloaded newer image for docker.io/jenkins:latest
811822122df6387146f3aa8778e81464467e158e70d28357f90b659a78e49459
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
811822122df6        jenkins             "/bin/tini -- /usr..."   14 seconds ago      Up 13 seconds       0.0.0.0:8080->8080/tcp, 50000/tcp   jenkins
```

Note! Make sure that docker run automatically downloaded the jenkins image
Note! jenkins container listens on port 8080

- Try to access Jenkins appliation from your workstation by opening the following URL

```
http://node1.172.24.0.11.nip.io:8080
```

or

```
http://172.24.0.11:8080
```

Note! You need to access the service from your Vagrant host and not inside the VM

Note! You should see the default Jenkins configration page named "Getting Started"


