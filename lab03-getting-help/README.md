# Lab3 - Getting help
This document will guide you on how to use builtin help of the Docker CLI via the "docker" utility

## The docker CLI
The docker CLI is provided by the docker utility.
- Check if the docker is installed:

```
[vagrant@node1 learn-docker]$ rpm -ql docker-client
/usr/bin/docker-current
/usr/share/licenses/docker-client-1.13.1
/usr/share/licenses/docker-client-1.13.1/LICENSE
/usr/share/licenses/docker-client-1.13.1/LICENSE-vim-syntax
```

- Check the docker script

```
[vagrant@node1 learn-docker]$ cat /usr/bin/docker
#!/bin/sh
. /etc/sysconfig/docker
[ -e "${DOCKERBINARY}" ] || DOCKERBINARY=/usr/bin/docker-current
if [ ! -f /usr/bin/docker-current ]; then
    if [ ! -f /usr/bin/docker-latest ]; then
        echo "You don't have either docker-client or \
docker-client-latest installed. Please install either one and retry."
        exit
    else
        DOCKERBINARY=/usr/bin/docker-latest
    fi
fi
if [[ ${DOCKERBINARY} != "/usr/bin/docker-current" && ${DOCKERBINARY} != /usr/bin/docker-latest ]]; then
    echo "DOCKERBINARY has been set to an invalid value:" $DOCKERBINARY
    echo ""
    echo "Please set DOCKERBINARY to /usr/bin/docker-current or /usr/bin/docker-latest
by editing /etc/sysconfig/docker"
else
    exec ${DOCKERBINARY} "$@"
fi
```

## Man pages
- Check the docker man page

```
man docker
```

Note! please focus on the subcommands. You may read a man page by "man docker-SUBCOMMAND"

- Check the man page for "docker info"

```
man docker-info
```

- Check the man page for "docker run"

``` 
man docker-run
``` 

- Check the "docker ps" man page

```
man docker-ps
```


## --help
Each docker subcommand has a builtin documentation. You may acces the documentation as follows:

```
docker --help
docker info --help
docker run --help
docker ps --help
```

## Getting docker version
```
$ docker version
Client:
 Version:         1.13.1
 API version:     1.26
 Package version: docker-1.13.1-84.git07f3374.el7.centos.x86_64
 Go version:      go1.10.2
 Git commit:      07f3374/1.13.1
 Built:           Fri Nov 30 02:48:45 2018
 OS/Arch:         linux/amd64

Server:
 Version:         1.13.1
 API version:     1.26 (minimum version 1.12)
 Package version: docker-1.13.1-84.git07f3374.el7.centos.x86_64
 Go version:      go1.10.2
 Git commit:      07f3374/1.13.1
 Built:           Fri Nov 30 02:48:45 2018
 OS/Arch:         linux/amd64
 Experimental:    false
$
```

## Getting help online
Visit [docs.docker.com](https://docs.docker.com) page, select your docker version (*Docker 1.13*) in a menu on a right side of the page. Explore documentation through the menu on the right side of the page.
