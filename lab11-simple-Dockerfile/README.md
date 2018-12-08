# Lab11 - Creating a simple Dockerfile

## Before we begin
- Remove all running and stopped containers
```
docker rm -f $(docker ps -aq)
```

## Building Apache image from Dockerfile

- Check Dockerfile in the "lab11-simple-Dockerfile" directory
- Build an Apache image using the following command

```
[vagrant@node1 lab11-simple-Dockerfile]$ docker build -t custom_httpd .
Sending build context to Docker daemon 6.144 kB
Step 1/3 : FROM centos:7
 ---> 75835a67d134
Step 2/3 : RUN yum install -y httpd &&     yum clean all &&     echo "It works" >/var/www/html/index.html
 ---> Using cache
 ---> 02597047832e
Step 3/3 : CMD /usr/sbin/httpd -DFOREGROUND
 ---> Using cache
 ---> 8710b43c848d
Successfully built 8710b43c848d
```

Note! Your output maybe different. The output above contains cached data to redunce number of lines.

- Make sure that images exists

```
[vagrant@node1 lab11-simple-Dockerfile]$ docker images custom_httpd
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
custom_httpd        latest              8710b43c848d        9 minutes ago       255 MB
```

- Check image properties

```
[vagrant@node1 lab11-simple-Dockerfile]$ docker inspect custom_httpd
[
    {
        "Id": "sha256:8710b43c848de77942f605e63808d101f1aa3d12e228c21f0b01c6e21f8ae08a",
        "RepoTags": [
            "custom_httpd:latest"
        ],
        "RepoDigests": [],
        "Parent": "sha256:02597047832ed42019f76e78fe30942a3037a13370681c0fe3220adedfd196fb",
        "Comment": "",
        "Created": "2018-12-04T10:05:19.352304506Z",
        "Container": "e7f1b8e187f80a21ffb87cb75b17db22f400e8c798eb9309635b419dad9b063b",
        "ContainerConfig": {
            "Hostname": "30c23a49fd4f",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "CMD [\"/bin/sh\" \"-c\" \"/usr/sbin/httpd -DFOREGROUND\"]"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:02597047832ed42019f76e78fe30942a3037a13370681c0fe3220adedfd196fb",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": {
                "org.label-schema.build-date": "20181006",
                "org.label-schema.license": "GPLv2",
                "org.label-schema.name": "CentOS Base Image",
                "org.label-schema.schema-version": "1.0",
                "org.label-schema.vendor": "CentOS"
            }
        },
        "DockerVersion": "1.13.1",
        "Author": "",
        "Config": {
            "Hostname": "30c23a49fd4f",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "/usr/sbin/httpd -DFOREGROUND"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:02597047832ed42019f76e78fe30942a3037a13370681c0fe3220adedfd196fb",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": {
                "org.label-schema.build-date": "20181006",
                "org.label-schema.license": "GPLv2",
                "org.label-schema.name": "CentOS Base Image",
                "org.label-schema.schema-version": "1.0",
                "org.label-schema.vendor": "CentOS"
            }
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 255480977,
        "VirtualSize": 255480977,
        "GraphDriver": {
            "Name": "overlay2",
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/c9bf27745489653a407f9e53f3fcb6bb2f96ca8299fb038873a6bf640ba815ce/diff",
                "MergedDir": "/var/lib/docker/overlay2/fd7f87ee1cf18eb388ddd8ab80163d37ccce6c1cbe410088be56793341cf88cb/merged",
                "UpperDir": "/var/lib/docker/overlay2/fd7f87ee1cf18eb388ddd8ab80163d37ccce6c1cbe410088be56793341cf88cb/diff",
                "WorkDir": "/var/lib/docker/overlay2/fd7f87ee1cf18eb388ddd8ab80163d37ccce6c1cbe410088be56793341cf88cb/work"
            }
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:f972d139738dfcd1519fd2461815651336ee25a8b54c358834c50af094bb262f",
                "sha256:4f97b9a13bd69a648a25e60befabc2f85a8d672e7194db43181af71e6d5b11ca"
            ]
        }
    }
]
```

## Image verification

- Start a new httpd container from the custom_httpd image

```
[vagrant@node1 ~]$ docker run -d --name httpd -p 8080:80  custom_httpd
ed81063df99bfd401b6a7fe0f69f5b180baa030f6c59eb3496f9c8a0da733364
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
ed81063df99b        custom_httpd        "/bin/sh -c '/usr/..."   3 seconds ago       Up 2 seconds        0.0.0.0:8080->80/tcp   httpd
```

- Access the service

```
[vagrant@node1 ~]$ docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd
172.17.0.2

[vagrant@node1 ~]$ curl 172.17.0.2
It works
```

- Remove all containers

```
docker rm -f $(docker ps -aq)
```

