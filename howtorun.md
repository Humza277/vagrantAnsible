# How to run this project

Prerequisites
- virtualBox [Link Here](https://www.virtualbox.org/wiki/Downloads)
- virtualBox [Link Here](https://www.vagrantup.com/downloads)


Download this repo 

Navigate to the directory with the vagrant file inside and run
    
    vagrant up
    
once the VM's have been created, run

    vagrant status

SSH into the aws VM
    
    vagrant ssh aws
    
To install Ansible onto our controller
    
    sudo apt-get install software-properties-common -y

    sudo apt-get update
    
    sudo apt-get install software-properties-common
    
    sudo apt-add-repository ppa:ansible/ansible
    
    sudo apt-get update
    
    sudo apt-get install ansible
    
    sudo apt-get install tree

Once this is done, we need to link the controller to the other VMs

    cd - to get into root of the controller
    
    cd/etc/ansible

    sudo su
    
    nano hosts
    
    copy and paste the following ensuring you comment out aws ip address
    
    [web]
    192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
    
    [db]
    192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
    
    [aws]
    192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant


Once this is done, you now need to make sure the hosts know about the controller-  to do this
    
    # WEB SERVER 
    ssh vagrant@192.168.33.10
    
    type vagrant
    
    sudo apt-get update -y
    
    sudo apt-get upgrade -y
    
    exit
    
    # DATABASE SERVER
    ssh vagrant@192.168.33.11
    
    type vagrant
    
    sudo apt-get update -y
    
    sudo apt-get upgrade -y
    
    exit
    
To check that they have all been linked correctly
    
    ansible all -m ping

Now all your machines have been provisioned properly - we now need to add the packages to each machine
this is done using a ansible playbook

    cd /home/vagrant/ansible

    ansible-playbook install.yml

The passoword to access the VM's is:   vagrant

This will install all packages onto the VM's and run the app on the web VM's IP address


To check it is running 

    http://192.168.33.10/
    
    http://192.168.33.10/fibonacci/8
    
    http://192.168.33.10/posts











# LEGACY --- Old Read Me 

We changed the code in our vagrant file 

add to the vagrant file

    aws.vm.synced_folder "app", "/home/vagrant/app"

ran vagrant up - to provision our servers
vagrant status to see all of the vms 

ssh into all the vms and update and upgrade them all 

installing ansible 
   
ssh into the aws server - aws server is the controller
    
    vagrant ssh aws
    run sudo apt-get install software-properties-common -y

install ansible

download repo
    
    sudo apt-add-repository --yes --update ppa:ansible/ansible;

to install
     
     sudo apt-get install ansible -y

install tree - is a package manager - lists the files in a nice way 
    
    sudo apt-get install tree -y

Then CD to the ansible folder

    cd /etc/ansible

Pings the hosts    
    
    ansible all -m ping
   
As we have not configured the hosts, it will not register
    
To configure the controller
    
    sudo nano hosts
add these to the file- tells the controller where the other servers are 
    
    [web]
    192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
    
    [db]
    192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
    
    [aws]
    192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
    

we have now told the controller where our other two servers are 
now we need to ping them
    
    ansible all -m ping
    
if it is still not working, ssh into them from the controller and run    
    
    
ssh vagrant@web 
    
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
