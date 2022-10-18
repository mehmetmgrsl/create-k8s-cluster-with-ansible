cd vagrant-provision
vagrant destroy -f
rm -rf .vagrant
vagrant up

cd ..

cd  kubeadm-ansible
sudo ansible-playbook -i hosts node-init.yml
sudo ansible-playbook -i hosts master-node-init.yml
sudo ansible-playbook -i hosts worker-node-init.yml