# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/trusty64"
    db.vm.host_name = "postgresql"
    db.vm.provision :shell, :path => "provisioning/setup-db.sh"
    db.vm.provider :virtualbox do |v|
        db.vm.network "private_network", ip: "172.31.32.51"
        db.vm.network "forwarded_port", guest: 5432, host: 15432
        v.name = "postgresql"
    end
  end
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/trusty64"
    web.vm.host_name = "webapp"
    web.vm.synced_folder "rest_demo", "/var/www/rest_demo",
                         owner: "ubuntu", group: "ubuntu"
    web.vm.provision :shell, :path => 'provisioning/setup-webapp.sh'
    web.vm.provider :virtualbox do |v|
        web.vm.network "private_network", ip: "172.31.32.52"
        web.vm.network "forwarded_port", guest: 80, host: 8000
        v.name = "webapp"
    end
  end
end
