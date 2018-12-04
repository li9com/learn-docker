# Lab3 - Getting help
This document guide you on how to use builtin help related to the Docker CLI via the "docker" utility

## The docker CLI
The docker CLI is provided by the docker utility.
- Check if the docker command is installed:

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
