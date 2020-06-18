# mutual aid ansible utilities

## what's this? 

Ansible is an open-source software provisioning/configuration/deployment automation tool. 

Here are some ansible utilities to aid in quick configuration and deployment of the mutual aid app. 

The cool thing about this is that pretty much all you have to do is figure out your hosts inventory, and set up your app configs. Just point the playbooks at the inventory, give it a rip, and once it's done, you can just hop on the app server and start your app!

Another cool thing is that all the stuff that takes place in the playbooks can be theoretically done manually, meaning that even if you're not trying to use ansible, you can use the playbooks as guidance regarding what needs to be sorted out in order to deploy the mutual aid app. 

Currently we only support Ubuntu 18.* for the ansible stuff. You can try it on any other distro that uses `apt` as a package manager, but we have not tested those scenarios yet. If you try it on another distro and it works, please let us know!


## prerequisites

* ansible 2.9.9

* at least ONE (1) ubuntu 18 box accessible via SSH by a user that can `sudo`.

## quickstart guide

### 1. sort out your configs and inventory !

First, create some inventory file. We'll call ours `example_inventory`. 
This file will be of the following format:
```
[app]
app.ip.here.lol
[database]
db.ip.here.lol
```

Note that the app ip and db ip can be the same ip if you want to have your database live on the same host as the app server. 

You should have SSH and sudo access to these ip addresses. Make sure you have already added the ECDSA fingerprint for the host, by SSHing into it at least once.

Now, you want to make a copy of the file `files/.env.example`, and call it `files/.env`. 
Replace the values for the variables as you see fit. 



### 2. run the playbook !

you can run the ansible playbooks like so: 
```
ansible-playbook -u your-ssh-username --ask-pass --ask-become-pass -i example_inventory playbook.yml
```

There are 3 playbooks available. 

* `dbserver.yml` : sets up a postgres database on the host specified under the `[database]` heading in your inventory. 

* `appserver.yml` : installs the mutual aid rails app and prerequisites. Copies over your config specified in `.env`. Runs on hosts specified under the `[app]` heading in your inventory.  

* `mutualaid.yml` : a top level playbook that runs both dbserver and appserver on their respective hosts. 


When you run this command, you will be prompted for your SSH pass. 
You will then be prompted for your "become" password, which is just fancy for the password you use to `sudo`. If this is the same as your SSH password, you can just hit enter. 


The playbook will take good amount of time to run. Nothing crazy, but still a good amount of time. This would be a perfect time to drink some water, do some stretches, and hang out outside for a bit if you are able. 


Hopefully (!) the playbook should run without a problem. 
Yellow `changed` events are fine. You just don't want to have any red `failed` events. 

If there is a problem, do not hesitate to reach out to us. Feel free to post a GitHub issue or chase us down on Slack. 

### 3. run your app!


If you are here, hopefully (!) the playbooks have successfully run against your inventory. 

Let's run our app!

First, SSH in to your app server.

You will be dropped in the home directory. 
Navigate to the code repo via
```
cd mutual-aid
```

export the environment variables via
```
. .env
```


and if this is your first time running this app, set your db up with
```
rails db:migrate
rake db:seed
```


and finally, run the app with the command
```
bundle exec rails server -p 3000 -b 0.0.0.0
```
Note this command defaults to the development environment. 
You can specify another environment with the `-e` flag, eg ` -e test `. 

This will start the application listening on port 3000. 

Point your browser to `http://app.ip.here.lol:3000`. 

If everything worked out, you should be faced with a basic deployment of the mutual aid app!


Note that this quickstart guide is not production ready!
The exposed app endpoint is not secured, and traffic  unencrypted!
This quickstart is good for a quick demo deployment. You should not submit any sensitive information on an unsecured endpoint. 

Hardening this set up for production will require some more in depth configuration. 



TODO: production steps? 




__________________________________
your friends at Mutual Aid Phoenix. 
https://www.mutualaidphx.com/