## Creating a K8s Cluster using Ansible

### 0. Provisioning nodes using Vagrant

A Kubernetes cluster will consist of one master and two worker nodes. For this, we will be using Vagrant and VirtualBox to quickly provision virtual machines.

Create a dedicated SSH key pair to connect to the VMs:

```ssh-keygen -b 4096```

```vagrant_key``` is used as a key name. 

### 1. Creating VMs

- There will be 3 VMs. One for the master node and others for the worker nodes.

- Run the following command on the root folder of the project:
    
    ```cd  vagrant-provision```

    ```vagrant up```

- The hostnames and IP addresses of the VMs are below:
  - master  : 192.168.56.10
  - node1   : 192.168.56.11
  - node2   : 192.168.56.12

### 2. Master and Worker Nodes Setups

    ```cd  kubeadm-ansible```

#### 2.1. Common setup for the nodes (master and workers)

```ansible-playbook -i hosts node-init.yml```

#### 2.2. Master node setup

```ansible-playbook -i hosts master-node-init.yml```

#### 2.3. Worker node setup

```ansible-playbook -i hosts worker-node-init.yml```

### 3. Check the Kubernetes cluster status

3.1 ```ssh vagrant@192.168.56.10 -i $HOME/.ssh/vagrant_key```

3.2 ```kubectl get nodes```


Resources:
1. https://imagdic.me/blog/create-kubernetes-cluster/
2. https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/
3. https://stackoverflow.com/a/61769800