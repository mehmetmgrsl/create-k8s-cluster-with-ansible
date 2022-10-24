## Creating a K8s Cluster using Ansible

### 0. Provisioning nodes using Vagrant

A Kubernetes cluster will consist of one master and one worker node. For this, we will be using Vagrant and VirtualBox to quickly provision virtual machines.

Create a dedicated SSH key pair to connect to the VMs:

```ssh-keygen -b 4096```

```vagrant_key``` is used as a key name. 

### 1. Creating VMs

- There will be 2 VMs. One for the master node and another for the worker node.

- Run the following command on the root folder of the project:
    
    ```cd  vagrant-provision```

    ```vagrant up```


 If Vms are ok then the following command should return SUCCESS like below:

 ```ansible -i hosts all -m ping```

 <code>
 worker1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}

master | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
 </code>
   

- The hostnames and IP addresses of the VMs are below:
  - master    : 192.168.56.15
  - worker1   : 192.168.56.16

### 2. Master and Worker Node Setups

```cd  kubeadm-ansible```

#### 2.1. Common setup for the nodes (master and worker)

```sudo ansible-playbook -i hosts node-init.yml```

Once the playbook is finished, we need to see content below:

<code> 
PLAY RECAP ***********************************************************************************

master                     : ok=14   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

worker1                    : ok=14   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
</code> 

#### 2.2. Master node setup

```sudo ansible-playbook -i hosts master-node-init.yml```

#### 2.3. Worker node setup

```sudo ansible-playbook -i hosts worker-node-init.yml```


NOTE: Instead of the commands under 1. and 2. above, you can simply run ```sh install.sh``` on the root folder.


### 3. Check the Kubernetes cluster status

3.1 ```ssh vagrant@192.168.56.15 -i $HOME/.ssh/vagrant_key```

3.2 ```kubectl get nodes```


or on the root folder of this project run the following commands:


```export KUBECONFIG=kubeadm-ansible/config```

```kubectl get nodes```

### 4. Delete VMs

```cd vagrant-provision```

```vagrant destroy```

```rm -rf .vagrant```


Resources:
1. [Create Kubernetes cluster with Ansible, Vagrant and kubeadm - Ivan Magdić](https://imagdic.me/blog/create-kubernetes-cluster/)
2. https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/
3. https://stackoverflow.com/a/61769800
