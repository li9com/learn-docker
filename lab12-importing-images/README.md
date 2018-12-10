# Lab12 - Importing and exporting images

This lab covers the following:
- Importing and exporting container layers
- Saving and loading docker images
- Creating an echo container image
- Create a base OS container image

## Importing and exporing container layers

- Check the "docker-import" and "docker-export" man pages

```
man docker-import
man docker-export
```

Note! We will be using the commands to import and export container layers.

- Start and modify a conftainer from the httpd image

```
docker run --name newhttpd -it httpd bash -c 'echo "New output" > /usr/local/apache2/htdocs/index.html'
```

- Export container layers

```
docker export newhttpd > /tmp/newhttpd.tar
```

- Import /tmp/newhttpd.tar as a new image

```
docker import /tmp/newhttpd.tar newimage
```

- Make sure that image exists

```
[vagrant@node1 ~]$ docker images newimage
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
newimage            latest              174a538aa225        51 seconds ago      128 MB
```

Note! This image is useless for now. We will learn how to improve it a bit later.

## Echo container image

- Determine which libraries are required for echo to work

```
[vagrant@node1 ~]$ ldd /bin/echo
	linux-vdso.so.1 =>  (0x00007fff1dfd0000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f6533e12000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f65341df000)
```

- Create a directory structure

```
mkdir -p /tmp/echo_image/{bin,lib64}
cp /bin/echo /tmp/echo_image/bin
cp /lib64/libc.so.6 /tmp/echo_image/lib64
cp /lib64/ld-linux-x86-64.so.2 /tmp/echo_image/lib64
```

- Create a tar archive

```
tar -C /tmp/echo_image -cf /tmp/echo_image.tar .
```

- Import tar file as a new container

```
[vagrant@node1 ~]$ docker import /tmp/echo_image.tar echo_image
sha256:b5071b42cd4b51a17e5836dfae3e04a85c93db2920c05ed75341b1b622c1bdf2
```

- Make sure that image exists

```
[vagrant@node1 ~]$ docker images echo_image
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
echo_image          latest              b5071b42cd4b        6 seconds ago       2.37 MB
```

- Make sure that image works

```
[vagrant@node1 ~]$ docker run echo_image /bin/echo "It works well"
It works well
```

## Loading and saving images

- Check the "docker-save" and "docker-load" man pages

```
man docker-save
man docker-load
```

- Save the httpd image

```
[vagrant@node1 ~]$ docker save httpd >/tmp/httpd.tar
[vagrant@node1 ~]$
```

- Check the the image format

```
[vagrant@node1 ~]$ tar -tvf /tmp/httpd.tar
drwxr-xr-x 0/0               0 2018-11-15 23:54 14048c84c24463b78e929c2dda49e7f4d2a97213d745cf6c97d9ed2b3dee0463/
-rw-r--r-- 0/0               3 2018-11-15 23:54 14048c84c24463b78e929c2dda49e7f4d2a97213d745cf6c97d9ed2b3dee0463/VERSION
-rw-r--r-- 0/0            2098 2018-11-15 23:54 14048c84c24463b78e929c2dda49e7f4d2a97213d745cf6c97d9ed2b3dee0463/json
-rw-r--r-- 0/0            3584 2018-11-15 23:54 14048c84c24463b78e929c2dda49e7f4d2a97213d745cf6c97d9ed2b3dee0463/layer.tar
-rw-r--r-- 0/0            7243 2018-11-15 23:54 2a51bb06dc8baa17b4d78b7ca0d87f5aadbd98d711817dbbf2cfe49211556c30.json
drwxr-xr-x 0/0               0 2018-11-15 23:54 449b1efccfaed5776f09e01aa12735e1fb6efd6579ef84a9e42ce6843b7ea317/
-rw-r--r-- 0/0               3 2018-11-15 23:54 449b1efccfaed5776f09e01aa12735e1fb6efd6579ef84a9e42ce6843b7ea317/VERSION
-rw-r--r-- 0/0             474 2018-11-15 23:54 449b1efccfaed5776f09e01aa12735e1fb6efd6579ef84a9e42ce6843b7ea317/json
-rw-r--r-- 0/0        34574848 2018-11-15 23:54 449b1efccfaed5776f09e01aa12735e1fb6efd6579ef84a9e42ce6843b7ea317/layer.tar
drwxr-xr-x 0/0               0 2018-11-15 23:54 5ba3fe577c09613f88f10dafcb7bc78e5480f36050a2db0cf4c6487d837d56cd/
-rw-r--r-- 0/0               3 2018-11-15 23:54 5ba3fe577c09613f88f10dafcb7bc78e5480f36050a2db0cf4c6487d837d56cd/VERSION
-rw-r--r-- 0/0             474 2018-11-15 23:54 5ba3fe577c09613f88f10dafcb7bc78e5480f36050a2db0cf4c6487d837d56cd/json
-rw-r--r-- 0/0            2560 2018-11-15 23:54 5ba3fe577c09613f88f10dafcb7bc78e5480f36050a2db0cf4c6487d837d56cd/layer.tar
drwxr-xr-x 0/0               0 2018-11-15 23:54 8609de5bc8b0a9aa9cbd2b0c09dfc5afb55857694aff09597bc19dac465d4c72/
-rw-r--r-- 0/0               3 2018-11-15 23:54 8609de5bc8b0a9aa9cbd2b0c09dfc5afb55857694aff09597bc19dac465d4c72/VERSION
-rw-r--r-- 0/0             398 2018-11-15 23:54 8609de5bc8b0a9aa9cbd2b0c09dfc5afb55857694aff09597bc19dac465d4c72/json
-rw-r--r-- 0/0        58435072 2018-11-15 23:54 8609de5bc8b0a9aa9cbd2b0c09dfc5afb55857694aff09597bc19dac465d4c72/layer.tar
drwxr-xr-x 0/0               0 2018-11-15 23:54 ab5e6b9a8945cebb4a3db2c5cb52c7c490f3ccd64670489615375e58ba04b95d/
-rw-r--r-- 0/0               3 2018-11-15 23:54 ab5e6b9a8945cebb4a3db2c5cb52c7c490f3ccd64670489615375e58ba04b95d/VERSION
-rw-r--r-- 0/0             474 2018-11-15 23:54 ab5e6b9a8945cebb4a3db2c5cb52c7c490f3ccd64670489615375e58ba04b95d/json
-rw-r--r-- 0/0        43591168 2018-11-15 23:54 ab5e6b9a8945cebb4a3db2c5cb52c7c490f3ccd64670489615375e58ba04b95d/layer.tar
-rw-r--r-- 0/0             519 1970-01-01 00:00 manifest.json
-rw-r--r-- 0/0              98 1970-01-01 00:00 repositories
```

- Delete httpd container image

```
docker rmi httpd
```

- Load an image from /tmp/httpd.tar

```
docker load -i  /tmp/httpd.tar
```
Note! There is no needs to specify image name since it is saved in image metadata file.

- Make sure that image exists with all metadata

```
[vagrant@node1 ~]$ docker images httpd
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
```

## Base OS images

The following script can be used to create a base os image

```
sudo mkdir /tmp/base
sudo yum install -y yum-utils
yumdownloader centos-release
sudo rpm --root /tmp/base --nodeps -ivh centos-release*.rpm
sudo yum --installroot=/tmp/base -y --setopt=tsflags=nodocs install yum
sudo rm -rf /tmp/base/var/cache/yum
```

- Create a tar archive

```
sudo tar -C /tmp/base -cf /tmp/centos7_base.tar .
```

- Import tar as a base os image

```
[vagrant@node1 ~]$ docker import /tmp/centos7_base.tar centos7_base
sha256:6a23396da346953675ad7ad1e14ecef60fd3bf50bf15d65ab95aabbb56136a1a
```

- Make sure that image exists

[vagrant@node1 ~]$ docker images centos7_base
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos7_base        latest              6a23396da346        6 seconds ago       256 MB
```

- Run container from newly created image

```
[vagrant@node1 ~]$ docker run -ti centos7_base /bin/bash
bash-4.2# exit
exit
[vagrant@node1 ~]
```

- Remove all containers

```
docker rm -f $(docker ps -aq)
```
