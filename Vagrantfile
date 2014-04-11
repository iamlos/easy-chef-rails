Vagrant.configure("2") do |config|
  config.vm.box = 'precise32'
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    chef.node_name      = "server"
    chef.roles_path     = "roles"
    chef.data_bags_path = "data_bags"
    chef.add_role("rails")
  end
end

