Vagrant.configure('2') do |config|

  config.vm.box = 'hashicorp/precise32'

  config.vm.define 'glassfish-example' do |client|
    client.vm.hostname = 'glassfish-example'

    client.ssh.forward_agent = true
    client.ssh.forward_x11 = true
    
    config.vm.network "forwarded_port", guest: 8080, host: 8080
	config.vm.network "forwarded_port", guest: 4848, host: 4848

    config.vm.provision :shell, :inline => 'apt-get update'
    config.vm.provision :shell, :inline => 'apt-get install build-essential ruby1.9.1-dev --no-upgrade --yes'
    config.vm.provision :shell, :inline => 'gem install chef --version 11.16.4 --no-rdoc --no-ri --conservative'

    client.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apt'
      chef.add_recipe 'java::default'
      chef.add_recipe 'glassfish::attribute_driven_domain'

      chef.json = {
        'java' => {
          'install_flavor' => 'oracle',
          'jdk_version' => 7,
          'oracle' => {
            'accept_oracle_download_terms' => true
          }
        },
        'glassfish' => {
          'version' => '4.1',
          'package_url' => 'http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip',
          'domains' => {
            'mydomain' => {
              'config' => {
                'port' => 7070,
                'admin_port' => 4848,
                'username' => 'admin',
                'password' => 'admin',
                'master_password' => 'mykeystorepassword',
                'remote_access' => true
              }
            }
          }
        }
      }
    end
  end
end
