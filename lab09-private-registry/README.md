# Lab9 - Working with registries
This lab explains how to create an internal registry

## Starting a registry from the official registry image

- Check official registry documentation at

```
https://hub.docker.com/_/registry
```
- Prepare persistent storage

```
sudo mkdir -p /data/registry
sudo chcon -t container_file_t /data/registry
```

- Pull registry image

```
docker pull registry:2
```

- Inspect docker registry image

```
[vagrant@node1 ~]$ docker inspect --format='{{ .Config.Volumes }}' registry:2
map[/var/lib/registry:{}]
```

Note! We need to mount persistent data to /var/lib/registry.

- Start registry container with the following configuration

Parameter      | Value
-------------- | -----
Exposed port   | 5000
Name           | registry
Volume         | /var/lib/registry is bound to /data/registry on the node
Restart policy | always

```
docker run -d -p 5000:5000 \
  -v /data/registry:/var/lib/registry \
  --restart always \
  --name registry registry:2
```

- Make sure that registry container works

```
[vagrant@node1 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
85d5f1e43f50        registry:2          "/entrypoint.sh /e..."   7 seconds ago       Up 6 seconds        0.0.0.0:5000->5000/tcp   registry
```

- Try to access registry service using curl. Make sure that it returns '{}'

```
[vagrant@node1 ~]$ curl http://localhost:5000/v2/
{}[vagrant@node1 ~]$
```

## Pushing images to registry
- Tag existing httpd images as localhost:5000/apache

```
docker tag httpd localhost:5000/apache
```

- Make sure that the image has been properly tagged

```
[vagrant@node1 ~]$ docker images localhost:5000/apache
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
localhost:5000/apache   latest              2a51bb06dc8b        3 weeks ago         132 MB
[vagrant@node1 ~]$ docker images httpd
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker.io/httpd     latest              2a51bb06dc8b        2 weeks ago         132 MB
```

- Push to registry localhost:5000/apache

```
[vagrant@node1 ~]$ docker push localhost:5000/apache
The push refers to a repository [localhost:5000/apache]
026f9bea4fc4: Pushed
de926190eb0b: Pushed
920e7ca5de49: Pushed
143e72edeb6d: Pushed
ef68f6734aa4: Pushed
latest: digest: sha256:63dba1dad8fe8a920226a631f8189d736b4a5129c2d2edc046a46f36ffc0091c size: 1367
```

- Make sure that image is stored on persistent storage

```
[vagrant@node1 ~]$ find /data/registry
/data/registry
/data/registry/docker
...
/data/registry/docker/registry/v2/repositories
/data/registry/docker/registry/v2/repositories/apache
/data/registry/docker/registry/v2/repositories/apache/_layers
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/ac13924397e3456b2a26d56bef26d5792cdbd978f72ef9cc1fb15a027e58c71d
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/ac13924397e3456b2a26d56bef26d5792cdbd978f72ef9cc1fb15a027e58c71d/link
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/a5a6f2f73cd8abbdc55d0df0d8834f7262713e87d6c8800ea3851f103025e0f0
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/a5a6f2f73cd8abbdc55d0df0d8834f7262713e87d6c8800ea3851f103025e0f0/link
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/992c7790d5f3a52fa534a56f857b11ebc49011ef1d23e5ae3ec6116105a011db
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/992c7790d5f3a52fa534a56f857b11ebc49011ef1d23e5ae3ec6116105a011db/link
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/2a51bb06dc8baa17b4d78b7ca0d87f5aadbd98d711817dbbf2cfe49211556c30
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/2a51bb06dc8baa17b4d78b7ca0d87f5aadbd98d711817dbbf2cfe49211556c30/link
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/fec7170426de5702cb93cc68c52509c9447b6ee881549abb4bcc5bccaa1b77c8
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/fec7170426de5702cb93cc68c52509c9447b6ee881549abb4bcc5bccaa1b77c8/link
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/91b81769f14a044f1deebeb7fdf5c0e743b6aef65ec2dfe1c8beb8d36a5dd875
/data/registry/docker/registry/v2/repositories/apache/_layers/sha256/91b81769f14a044f1deebeb7fdf5c0e743b6aef65ec2dfe1c8beb8d36a5dd875/link
/data/registry/docker/registry/v2/repositories/apache/_uploads
/data/registry/docker/registry/v2/repositories/apache/_manifests
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags/latest
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags/latest/current
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags/latest/current/link
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags/latest/index
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags/latest/index/sha256
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags/latest/index/sha256/63dba1dad8fe8a920226a631f8189d736b4a5129c2d2edc046a46f36ffc0091c
/data/registry/docker/registry/v2/repositories/apache/_manifests/tags/latest/index/sha256/63dba1dad8fe8a920226a631f8189d736b4a5129c2d2edc046a46f36ffc0091c/link
/data/registry/docker/registry/v2/repositories/apache/_manifests/revisions
/data/registry/docker/registry/v2/repositories/apache/_manifests/revisions/sha256
/data/registry/docker/registry/v2/repositories/apache/_manifests/revisions/sha256/63dba1dad8fe8a920226a631f8189d736b4a5129c2d2edc046a46f36ffc0091c
/data/registry/docker/registry/v2/repositories/apache/_manifests/revisions/sha256/63dba1dad8fe8a920226a631f8189d736b4a5129c2d2edc046a46f36ffc0091c/link
```

- Remove all local httpd container images

```
docker rmi apache docker.io/httpd localhost:5000/apache docker.io/centos/httpd-24-centos7
```

- Start a httpd container from localhost:5000/apache

```
[vagrant@node1 ~]$ docker run -d --name httpd localhost:5000/apache
Unable to find image 'localhost:5000/apache:latest' locally
Trying to pull repository localhost:5000/apache ...
latest: Pulling from localhost:5000/apache
a5a6f2f73cd8: Already exists
ac13924397e3: Pull complete
91b81769f14a: Pull complete
fec7170426de: Pull complete
992c7790d5f3: Pull complete
Digest: sha256:63dba1dad8fe8a920226a631f8189d736b4a5129c2d2edc046a46f36ffc0091c
Status: Downloaded newer image for localhost:5000/apache:latest
54fff350f32410101da94daefa56af2d31b66ad6bd4e167b6611f85ff989df4b
```

- Make sure the Apache service works propery

```
[vagrant@node1 ~]$ curl http://$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' httpd)
<html><body><h1>It works!</h1></body></html>
```

- Delete all containers

```
docker rm -f $(docker ps -aq)
```
