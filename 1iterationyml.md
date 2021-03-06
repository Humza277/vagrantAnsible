                                                                                                                                                                                                                                                                                                                                                                                                                                                                       install.yml
# This is a YAML file to install nginx onto oue web VM using YAML

---

- hosts: db

  gather_facts: yes

  become: true

  tasks:
  - name: install mongodb
    apt: pkg=mongodb state=present

  - name: Remove mongodb file (delete file)
    file:
      path: /etc/mongodb.conf
      state: absent

  - name: Touch a file, using symbolic modes to set the permissions (equivalent to 0644)
    file:
      path: /etc/mongodb.conf
      state: touch
      mode: u=rw,g=r,o=r


  - name: Insert multiple lines and Backup
    blockinfile:
      path: /etc/mongodb.conf
      block: |
        # mongodb.conf
        storage:
          dbPath: /var/lib/mongodb
          journal:
            enabled: true
        systemLog:
          destination: file
          logAppend: true
          path: /var/log/mongodb/mongod.log

        net:
          port: 27017
          bindIp: 0.0.0.0


# where do we want to install
- hosts: web

# get the facts
  gather_facts: yes

# changes access to root user
  become: true

# what do we want ansible to do for us in the playbook
# In this case our only task is to install nginx

  tasks:
  - name: Install nginx
    apt: pkg=nginx state=present
    become_user: root

  - name: Remove nginx deafault file (delete file)
    file:
      path: /etc/nginx/sites-enabled/default
      state: absent

  - name: Touch a file, using symbolic modes to set the permissions (equivalent to 0644)
    file:
      path: /etc/nginx/sites-enabled/reverseproxy.conf
      state: touch
      mode: '666'


  - name: Insert multiple lines and Backup
    blockinfile:
      path: /etc/nginx/sites-enabled/reverseproxy.conf
      block: |
        server{
          listen 80;
          server_name development.local;
          location / {
              proxy_pass http://127.0.0.1:3000;
          }
        }

  - name: Create a symbolic link
    file:
      src: /etc/nginx/sites-enabled/reverseproxy.conf
      dest: /etc/nginx/sites-available/reverseproxy.conf
      state: link



  - name: nginx bug workaround
    shell: |
      sudo mkdir /etc/systemd/system/nginx.service.d
        # prints a inline statement to restart the ngix module
        printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" | \
          # overrides the old file with our new one
          sudo tee /etc/systemd/system/nginx.service.d/override.conf
      # restart the entire daemon
      sudo systemctl daemon-reload
      # restart the nginx module
      sudo systemctl restart nginx

  - name: Install nodejs
    apt: pkg=nodejs state=present

  - name: Install NPM
    apt: pkg=npm state=present

# Downloading pm2
  - name: Install pm2
    npm:
      name: pm2
      global: yes

  - name: download latest npm
    shell: |
      npm install -g npm@latest
      npm install mongoose -y


  - name: Copy web app into web virtual machine
    synchronize:
      src: /home/vagrant/app
      dest: /home/vagrant


  - name: set up app
    shell: |
      cd app/
      npm install
      node seeds/seed.js
      pm2 kill
      pm2 start app.js
    environment:
      DB_HOST: mongodb://vagrant@192.168.33.11:27017/posts?authSource=admin
    become_user: root
































