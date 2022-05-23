IMAGE_NAME = "bento/ubuntu-20.04"
N = 2

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.define "master" do |master|
      master.vm.hostname = "master"
      master.vm.box = IMAGE_NAME
      master.vm.network "private_network", ip: "192.168.56.70"
      master.vm.provision "ansible" do |ansible|
          ansible.playbook = "kubernetes-setup/master-playbook.yml"
          ansible.extra_vars = {
              node_ip: "192.168.56.70",
          }
      end
  end

  (1..N).each do |i|
    config.vm.define "node#{i}" do |node|
        node.vm.hostname = "node#{i}"
        node.vm.box = IMAGE_NAME
        node.vm.network "private_network", ip: "192.168.56.7#{i}"
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = "kubernetes-setup/node-playbook.yml"
          ansible.extra_vars = {
              node_ip: "192.168.56.7#{i}",
          }
      end
    end
  end
end
