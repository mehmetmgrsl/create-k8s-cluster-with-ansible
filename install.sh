cd vagrant-provision
vagrant destroy -f
rm -rf .vagrant
vagrant up

cd ..

cd  kubeadm-ansible
ansible -i hosts all -m ping
sudo ansible-playbook -i hosts node-init.yml
ansible -i hosts all -m ping
sudo ansible-playbook -i hosts master-node-init.yml
ansible -i hosts all -m ping
sudo ansible-playbook -i hosts worker-node-init.yml
ansible -i hosts all -m ping