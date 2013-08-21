Vagrant.configure("2") do |config|
  # set the chef version
  config.omnibus.chef_version = :latest

  # enable berkshelf
  config.berkshelf.enabled = true

  # Configure base box parameters
  config.vm.box = "precise-server-cloudimg-amd64-vagrant-disk1"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.hostname = "vagrant-windows"

  config.vm.provider :virtualbox do |vb|
    # Give enough horsepower to build without taking all day.
    vb.customize [
      "modifyvm", :id,
      "--memory", "1024",
      "--cpus", "2",
    ]
  end

  config.vm.provision :chef_solo do |chef|
    # Firewall blocks git protocol
    chef.json = {
      "rbenv" => {
        "git_repository" => "https://github.com/sstephenson/rbenv.git"
      },
      "ruby_build" => {
        "git_repository" => "https://github.com/sstephenson/ruby-build.git"
      }
    }
    chef.run_list = [
      "recipe[apt]",
      "recipe[vagrant-windows]"
    ]
  end
end