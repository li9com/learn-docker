Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = 'node1.172.24.0.11.nip.io'
  config.vm.network "private_network", ip: "172.24.0.11"
  config.vm.provider "virtualbox" do |v|
     v.memory = 4096
     v.cpus = 2
  end
  config.vm.provision "shell", inline: $script
end


$script = <<SCRIPT
  groupadd docker
  usermod -aG docker vagrant
  yum install docker git -y
  systemctl enable docker --now
SCRIPT
