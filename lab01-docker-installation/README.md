# Lab1 - Docker installation
This document explains how to install Docker on a CentOS 7 VM.
The lab environment comes with Docker pre-installed and in most cases you do not need to implement this scenario. However, if you use your own VM, you would need to install Docker packages and start the docker service.

## Installation
- Install the "docker" package as follows:

```
sudo yum install docker -y
```

## Start the service
- Start the docker service as follows:

```
sudo systemctl enable --now docker
```
Note! This command starts the docker service and enables it to start on boot

## Verification
- Check the docker service status as follows:

```
sudo systemctl status docker
```

You showd have a similar ouput:

```
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-12-03 23:51:26 UTC; 29min ago
     Docs: http://docs.docker.com
 Main PID: 4633 (dockerd-current)
   CGroup: /system.slice/docker.service
           ├─4633 /usr/bin/dockerd-current --add-runtime docker-runc=/usr/libexec/docker/docker-runc-current --default-runtime=docker-runc -...
           └─4639 /usr/bin/docker-containerd-current -l unix:///var/run/docker/libcontainerd/docker-containerd.sock --metrics-interval=0 --s...
```
