Vagrant.configure(2) do |config|

  config.vm.box = "hashicorp/precise32"

  # If your system dont support 64
  #config.vm.box = "hashicorp/precise32"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provision :shell, :path => "provision.sh", keep_color: true

end
