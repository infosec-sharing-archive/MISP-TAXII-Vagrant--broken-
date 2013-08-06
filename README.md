MISP-TAXII-Vagrant
==================
Vagrant virtual applicance and puppet configuration management

Requirements
============
* VirtualBox https://www.virtualbox.org/wiki/Downloads
* Vagrant http://downloads.vagrantup.com/


Installation
============

    git clone https://github.com/MISP/MISP-TAXII-Vagrant.git
    cd MISP-TAXII-Vagrant
    vagrant up

Usage
=====

After installation you'll have a TAXII Inbox service available at
http://127.0.0.1:4242/taxii/inbox.

You can use the taxii_client.py to push MISP data which will be saved in
mysql://root@127.0.0.1:3306/CTI_db_test
