WE changed the file of our vagrant file 

ran vagrant up - to provision our servers
vagrant status to see all of the vms 

ssh into all the vms and update and upgrade them all 

installing ansible 
   
ssh into the aws server
    vagrant ssh aws
    run sudo apt-get install software-properties-common -y

install ansible

download repo
    sudo apt-get install software-properties-common -y

to install
     sudo apt-get install ansible -y

install tree - is a package manager - lists the files in a nice way 
    sudo apt-get install tree -y

cd /etc/ansible

ansible all -m ping

ssh vagrant@web

sudo nano hosts

add to file - tells the controller where the other servers are 
[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[aws]
192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
    

we have now told the controller where our other two servers are 
now we need to ping them

password is vagrant 
aws to web
ssh vagrant@192.168.33.10
update
exit

aws to db
ssh vagrant@192.168.33.11
update
exit

ansible all -m ping

should be all working now 

