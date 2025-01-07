# Cookbook Name:: errbit
# Attributes:: defaul

#Default values for user creation
default['user']['name'] = 'meus'
default['user']['uid'] = '1005'
default['user']['gid'] = '1005'
default['user']['path'] = "/home/#{node['user']['name']}"
default['user']['password'] = '$6$YJUoGD0eu5iQTw/N$1UURr27sz/XIEXBAClNFrmuhCs.dzxP4QsStn33Fgyc3GAuynktCBRV8UztGS0zK4reBFoJL10896pGIXs/2T1'
default['user']['shell'] = '/bin/bash'

#Default values for the Errbit application
default['errbit']['repo'] = 'https://github.com/errbit/errbit.git'
default['errbit']['destination'] = "#{node['user']['path']}/errbit"
default['errbit']['admin']['name'] = 'admin'
default['errbit']['admin']['password'] = 'adminpassword'
default['errbit']['admin']['email'] = 'your_email@example.com'
default['errbit']['default']['port'] = '3000'
default['errbit']['default']['address'] = '0.0.0.0'

#Values for Ruby Version Manager(RVM)
default['rvm']['bin']="#{node['user']['path']}/.rvm/bin/rvm"
default['rvm']['openssl']['path'] = "#{node['user']['path']}/.rvm/usr/bin/openssl"
default['rvm']['wrapper']['gem'] = "#{node['user']['path']}/.rvm/wrappers/ruby-2.7.6/gem"
default['rvm']['wrapper']['bundle'] = "#{node['user']['path']}/.rvm/wrappers/ruby-2.7.6/bundle"

#Specifies the version of the mongodb package to be installed by default
#Defining a repository to install mongodb
default['mongodb']['package_version'] = '8.0.0'
if platform_family?('debian')
  if platform?('ubuntu')
    default['mongodb']['repo'] = 'http://repo.mongodb.org/apt/ubuntu'
  elsif platform?('debian')
    default['mongodb']['repo'] = 'http://repo.mongodb.org/apt/debian'
    if node['lsb']['release'].to_i == 11
     default['mongodb']['package_version'] = '6.0.0'
    end
  end
end
