# Learn Docker
"Learn Docker" is is a step by step hands-on guide which teaches some practical Docker-related skills


## Labs
The repository consists of a number of subdirectories, which include all files required for the Labs.
Labs are structured as follows:

Lab    | Description
------ | -----------
Lab 0  | Creating Lab environment (please see below in this document)
Lab 1  | Docker installation
Lab 2  | Docker basic configuration
Lab 3  | Getting help
Lab 4  | Manaing images
Lab 5  | Managing containers
Lab 6  | Using environment variables
Lab 7  | Using persistent storage
Lab 8  | Starting multicontainer applications
Lab 9  | Starting private registry
Lab 10 | Creating new images with docker commit
Lab 11 | Creating a simple Dockerfile
Lab 12 | Importing and exporting images
Lab 13 | Advanced Dockerfile
Lab 14 | Containerizing Jboss EAP


## Creating Lab environment
Most of the labs can be run on any Linux based VMs. However all labs are created and tested on CentOS 7 only.

### Virtual Machine
The repsitory includes a Vagrantfile which deploys a VM with the following configuration:

Option   | Value
-------- | -----
RAM      | 4096M
vCPU     | 2
IP       | 172.24.0.11
Hostname | node1.172.24.0.11.nip.io
Box      | centos/7

### Additional configuration

The VM is customized as follows:
- docker and git packages are installed
- docker Linux group is created
- vagrant user is a member of the docker Linux group (this allows to use Docker client under unprivileged user)


### Host machine requrements

The host machine can be configured on the following OS:
- MacOS
- Windows
- Fedora Linux
- CentOS 7

The following software is required:
- VirtualBox (Windows and MacOS)
- libvirt (Linux only)
- Vagrant
- git
- vim


### Starting lab environment
The lab environment can be provisioned using Vagrant as follows:

```
git clone https://github.com/li9com/learn-docker.git
cd learn-docker
vagrant up
```

### Connecting to the Lab VM

Once the VM is provisioned, you may connect to it using SSH as follows:

```
vagrant ssh
```

Note! You will be connected as the "vagrant" user which is allowed to use sudo to run commands under the root account:

```
sudo yum install -y epel-release
```


## Authors
Artemii Kropachev


