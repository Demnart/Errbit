default['mongodb']['package_version'] = '8.0.0'
default['user']['name'] = 'meus'
default['user']['uid'] = '1000'
default['user']['gid'] = '1000'
default['user']['path'] = "/home/#{node['user']['name']}"
default['user']['password'] = '$6$xieb2fuF$NHsnWjvf3RhwpA9Ld/ARZbtAy3ImUzaJWM1WRmvPcaRuNzJjf6Qdb7.Z5JsFLvMTyp9ESN60gT9w6XY.hcc4A1'
default['user']['shell'] = '/bin/bash'



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

