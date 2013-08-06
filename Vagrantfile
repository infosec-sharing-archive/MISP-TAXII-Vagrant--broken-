# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "raring64"
    config.vm.box_url = "http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-amd64-disk1.box"
    config.vm.hostname = "misp-taxii"
    config.vm.network :private_network, ip: "10.0.0.2"
    config.vm.network :forwarded_port, guest: 80, host:4242

    #config.vm.provision :shell, :inline => "sudo puppet module install puppetlabs/vcsrepo"
    config.vm.provision :shell, :path => "bootstrap.sh"

    config.vm.provision :puppet do |puppet|
        puppet.options        = "--verbose --debug"
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path    = "puppet/modules"
        puppet.manifest_file  = "default.pp"
    end

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

end
