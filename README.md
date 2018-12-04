# learn-docker
"Learn Docker" is is a step by step hands-on guide which gives some practical Docker-related examples


## Labs
The repository gives a number of folders which proides all files required for a Lab.
The lab are structured as follows:

Lab    | Description
------ | -----------
Lab 0  | Creating lab environment (please see below in this document)
Lab 1  | Docker installation
Lab 2  | Docker basic configuration 


## Creating lab environment
Most of the labs can be run on any Linux based VMs. However all labs are created and tested on CentOS 7 only.

### Virtual Machine
The repsitory includes a Vagrantfile which deploys a VM with the following configuration option:

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
- docker Linux groups is created
- the vagrant user is a member of the docker Linux group (this allows to use Docker client under unprivileges user)


### Host machine requrements

The host machine can be configured on the following OS:
- MacOS
- Windows
- Fedora Linux
- CentOS 7

The following software is required:
- VirtualBox(Windows and MacOS)
- libvirt(Linux only)
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

### Connecting to Lab VM

Once VM is provisioned, you may connect to VM using SSH as follows:

```
vagrant ssh
```

Note! You will be connected as the "vagrant" user which is allowed to use sudo to run commands under the root account:

```
sudo yum install -y epel-release
```


## Authors
Artemii Kropachev


