# ruby-on-rails-vagrant

A vagrant file for the course 1dv450, Linnaeus University, Sweden, Kalmar
The installation will take 10-15 minutes the first time.

Add the vagrantfile and the provision.sh to your own repo and run "vagrant up"

## The Vagrantfile
The vagrantfile installs:
- Ubuntu ("hashicorp/precise64") if your system dosn´t support 64 change the vagrantfile to "hashicorp/precise32"

- rvm (latest)
- ruby (latest)
- Rails (latest)
- SQLLite
- postgreeSQL
- node.js

## using vagrant
To install (first time) and start the virtual machine ```vagrant up```

The go to the vagrant folder (this is mirrored to your host OS)
``` cd /vagrant ```

from here you can make a new rails application.

When you ready run ```vagrant halt``` to halt the virtual machine.
Dont forget to commit and push your code
