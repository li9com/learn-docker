# Lab1 - Docker installation
This document explains how to configure Docker on a CentOS 7 machine.
The lab environment comes with Docker pre-installed and in most cases you do not need to implement this scenario. However, if you use an external node, you may need to install Docker packages and start the docker service.

## Configuration
- Check Docker daemon startup options as follows:

```
systemctl status -l docker
```

- Check docker.service systemd file:

```
cat /usr/lib/systemd/system/docker.service 
```

You should see a similar output:

```
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-12-03 23:51:26 UTC; 35min ago
     Docs: http://docs.docker.com
 Main PID: 4633 (dockerd-current)
   CGroup: /system.slice/docker.service
           ├─4633 /usr/bin/dockerd-current --add-runtime docker-runc=/usr/libexec/docker/docker-runc-current --default-runtime=docker-runc --exec-opt native.cgroupdriver=systemd --userland-proxy-path=/usr/libexec/docker/docker-proxy-current --init-path=/usr/libexec/docker/docker-init-current --seccomp-profile=/etc/docker/seccomp.json --selinux-enabled --log-driver=journald --signature-verification=false --storage-driver overlay2
           └─4639 /usr/bin/docker-containerd-current -l unix:///var/run/docker/libcontainerd/docker-containerd.sock --metrics-interval=0 --start-timeout 2m --state-dir /var/run/docker/libcontainerd/containerd --shim docker-containerd-shim --runtime docker-runc --runtime-args --systemd-cgroup=true
```

- Check the content of the configuration files:

```
cat /run/containers/registries.conf
cat /etc/sysconfig/docker
cat /etc/sysconfig/docker-storage
cat /etc/sysconfig/docker-network
```

Note! it is expected that /run/containers/registries.conf doesn't exist by default
