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

