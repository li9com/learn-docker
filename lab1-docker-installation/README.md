# Lab1 - Docker installation
This document explains how to install Docker on a CentOS 7 machine.
The lab environment comes with Docker pre-installed and in most cases you do not need to implement this scenario. However, if you use an external node, you may need to install Docker packages and start the docker service.

## Installation
- Install the "docker" package as follows:

```
yum install docker -y
```

## Start the service
- Start the docker service as follows:

```
systemctl enable --now docker
```
