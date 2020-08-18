# What is Ansible?

![ansible](src="/images/ansible.png")


Ansible is an open-source, configuration management tool to provision IT environments, deploy software or be integrated to CI/CD pipelines.

Ansible helps improve the scalability, consistency and reliability of your IT environment

Ansible can automate repetitive system administration tasks

Ansible uses SSH to push changes from a single source to multiple remote resources

# What does open-source mean?
Software that is designed to be publicly accessible
Anyone can see, modify, and distribute the code as they see fit.

# What can Ansible automate?
Provisioning: Set up various servers (e.g Nginx web server) you need in your infrastructure

Configuration management: Changes the configuration of an application, OS, or device; start and stop services; install or update applications; implement a security policy; or perform a wide variety of other configuration tasks.

Application deployment: Make DevOps easier by automating the deployment of internally developed applications to your production systems.

Security and Compliance:
https://www.edureka.co/blog/what-is-ansible/

# Why Ansible?
Simplicity
Ansible uses YAML, a simple configuration language rather than Ruby which Puppet and Chef use.
Ansible deployment is also agentless, meaning instead of installing an agent on every system you want to manage, Ansible just requires that systems have Python (on Linux servers) or PowerShell (on Window servers) and SSH

Agentless means Ansible works by connecting to our virtual machines through SSH (by default).
Ansible is a helpful tool that allows you to create multiple virtual machines and describe how these machines should be configured or what actions should be taken on them.
Ansible issues all commands from a central location to perform these tasks.

No other client software is installed and uses SSH to connect to the nodes.
Only Ansible needs to be installed on the control machine (the machine from which you will be running commnads)

It is efficient: No extra software, more resources for your applications. Ansible modules work via JSON, therefore Ansible is extensible with modules written in a programming language you're already familiar with.
Cost effective: by building consistent ephemeral environments for staging, tests, or QA.

# What is YAML?
Human-readable data serialisation language
Simple syntax, stands for Yet Another Markup Language

# What does agentless mean?
Refers to operations where no service, daemon or process needs to run in the background on the machine.
Agentless doesn't require any agent to be installed for monitoring.

You don't need to install software or firewall ports on the nodes that it manages.
E.g you don't need to install Python, because it's already pre-installed in our Virtual Machine.
No need to install dependencies

# What is Configuration Management?
Chef, Puppet
They help configure the software and systems on this infrastructure that has already been provisioned.
It maintains configuration of the product performance by keeping a record and updating detailed information which describes an enterprise's hardware and software.

# What is Infrastructure as Code?
Type of IT setup wherein developers or operations team automatically manage and provision technology stack for an application through software e.g. Ansible, rather than using a manual process to configure hardware devices and operating systems.
Process of managing and provisioning computer data centers through machine-readable definition files e.g YAML or Ruby, rather than physical hardware configuration.
Process of automating your infrastructure deployments

# Infrastructure as Code tools
Terraform
Provisioning tool
Allows you to describe your infrastructure as code and creates 'execution plans' that outline exactly what will happen when you run your code.

# How does Ansible fit into DevOps?
Extracted from TechBeacon
Simple IT automation, automating repeatable tasks like provisioning, configuration, and deployments for one machine or millions.
Accelerates feedback loop
Discover bugs sooner

# More reliable deployments
Ansible is agentless meaning no additional software or firewall ports are required and you do not have to separately set up a management infrastructure which includes managing your entire systems, network and storage.
Ansible further reduces the effort required for your team to start automating right away.
Ansible isn't just about automation. IaC requires DevOps practices to automation scrips to ensure they're free of errors, are able to be redeployed on multiple servers and can be rolled back in case of problems, and can be engaged by both operations and development teams.

# Best practices of IaC:
1.Managing infrastructure via source control, providing a detailed audit trail for changes. 2.Applying testing to infrastructure in the form of unit testing, functional testing, and integration testing. 3.Avoid written documentation, since the code itself will document the state of the machine. This is particularly powerful because it means, for the first time, that infrastructure documentation is always up to date. 4.Enables collaboration around infrastructure configuration and provisioning, most notably between dev and ops.

# Walkthrough
We changed the file of our vagrant file 

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

# Ansible Ad-Hoc Commands

An Ansible ad-hoc command uses the /usr/bin/ansible command-line tool to automate a single task on one or more managed nodes. 
Ad-hoc commands are quick and easy, but they are not reusable. 

ansible web -a "date"

ansible db -a "uname -a"

ansible all -m shell -a "ls -a"

ansible all -m shell -a "free"

ad-hoc command to find out up-time
    ansible all -m shell -a 'uptime' --become
    
disk space
    ansible all -a "df -h"
    
IP
    ansible db -m shell -a "hostname -I"
    
# Playbooks

written in YAML
allow you to provision multiple servers :
    ---
        #where do we want to install

- hosts: web

        # get the facts
  gather_facts: yes

        #  work from root user
  become: true

        # what do we want asible to do for us in this playbook

  tasks:
  - name: Install nginx
        # gets the nginx package, present = install
    apt: pkg=nginx state=present
        # command to run playbook : ansible=playbook 'name of the file
  tasks:
  - name: Install nodejs
    apt: pkg=nodejs state=present

  tasks:
  - name: Install npm
    apt: pkg=npm state=present


scp -r app/ ubuntu@192.168.33.10:/home/ubuntu/




  GNU nano 2.9.3                                                                                                                                                                           install.yml                                                                                                                                                                            Modified


---
#where do we want to install

- hosts: web

# get the facts
  gather_facts: yes

#  work from root user
  become: true

# what do we want asible to do for us in this playbook

  tasks:
  - name: Install nginx
    # gets the nginx package, present = install
    apt: pkg=nginx state=present
# command to run playbook : ansible=playbook 'name of the file
  - name: Install Git
    apt: pkg=git state=presest

  - name: Install nodejs dependancies
    command: apt-get install software-properties-common -y
    ignore_errors: True

  - name: download nodejs dependancies
    shell: curl -sl https://deb.nodesource.com/setup_12.x | sudo -E bash -
    ignore_errors: True

  - name: install nodejs
    apt: pkg=nodejs state=present

  - name: Disable NGINX Default Virtual Host
    shell: rm /etc/nginx/sites-enabled/default


  - name: Create Nginx Conf File for port 80
    shell: cp /home/vagrant/nginx

  - name: Amend Nginx file
    become: yes
    blockinfile:
         path: /etc/nginx/sites-available/reverse-proxy.conf
         marker: ""
         block: |
          server {
              listen 80;
              server_name development.local;
                 location / {
                   proxy_pass http://127.0.0.1:3000/;

  - name: Link Nginx
    become: yes
    command:
      cnd: ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf


  - name: Make sure Nginx service is running
    become: yes
    service:
      name: nginx
      state: restarted
      enabled: yes


  - name: Install npm
    apt: pkg=npm state=present






