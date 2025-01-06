default['mongodb']['package_version'] = '8.0.0'
default['user']['name'] = 'meus'
default['user']['uid'] = '1000'
default['user']['gid'] = '1000'
default['user']['path'] = "/home/#{node['user']['name']}"
default['user']['password'] = '$6$xieb2fuF$NHsnWjvf3RhwpA9Ld/ARZbtAy3ImUzaJWM1WRmvPcaRuNzJjf6Qdb7.Z5JsFLvMTyp9ESN60gT9w6XY.hcc4A1'
default['user']['shell'] = '/bin/bash'

default['errbit']['repo'] = 'https://github.com/errbit/errbit.git'
default['errbit']['destination'] = "#{node['user']['path']}/errbit"
default['errbit']['admin']['name'] = 'admin'
default['errbit']['admin']['password'] = 'adminpassword'
default['errbit']['admin']['email'] = 'your_email@example.com'
default['errbit']['default']['port'] = '3000'

default['rvm']['bin']="#{node['user']['path']}/.rvm/bin/rvm"
default['rvm']['openssl']['path'] = "#{node['user']['path']}/.rvm/usr/bin/openssl"
default['rvm']['wrapper']['gem'] = "#{node['user']['path']}/.rvm/wrappers/ruby-2.7.6/gem"
default['rvm']['wrapper']['bundle'] = "#{node['user']['path']}/.rvm/wrappers/ruby-2.7.6/bundle"



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

