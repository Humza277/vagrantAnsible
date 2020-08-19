#!/bin/bash

#vagrant reload
vagrant up
ssh vagrant@192.168.33.12 << EOF
sudo apt-get install software-properties-common -y
sudo apt-get install tree -y
sudo apt-add-repository--yes--update ppa:ansible/ansible
sudo apt-get install ansible -y
sudo apt-get install sshpass -y

echo "AWS IS DONE"

sudo su
cd /etc/ansible
echo "[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
echo  "[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
echo  "[aws]
192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
cd ..

echo "HOSTS HAVE BEEN ADDED"

#go into web server
sshpass -p 'vagrant' ssh vagrant@192.168.33.10
sudo apt-get update -y
sudo apt-get upgrade -y
echo "WEB IS DONE"
exit

#go into dev server
sshpass -p 'vagrant' ssh vagrant@192.168.33.11
sudo apt-get update -y
sudo apt-get upgrade -y
echo "DATABASE IS DONE"
exit
EOF


scp -r ~/Documents/vagrant-Ansible/install.yml vagrant@192.168.33.12:/home/vagrant/

#apt-get install rsync
#rsync --chmod=u+rwx ~/Documents/vagrant-Ansible/install.yml/ vagrant@192.168.33.12:/etc/ansible

ssh vagrant@192.168.33.12 << EOF
sudo mv install.yml /etc/ansible/
exit
EOF

ssh vagrant@192.168.33.12 << EOF
sudo su
cd /etc/ansible
echo "[defaults]
host_key_checking = false" >> ansible.cfg
exit
EOF

ssh vagrant@192.168.33.12 << EOF
cd /etc/ansible
ansible-playbook install.yml
exit
EOF
