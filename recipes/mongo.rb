package_version_major = node['mongodb']['package_version'].to_f

apt_repository 'mongodb' do
  uri          node['mongodb']['repo']
  distribution "#{node['lsb']['codename']}/mongodb-org/#{package_version_major}"
  components   platform?('ubuntu') ? ['multiverse'] : ['main']
  key "https://www.mongodb.org/static/pgp/server-#{package_version_major}.asc"
end

apt_package 'mongodb-org' do
  action :install
end

systemd_unit 'mongod' do
  action [:start, :enable]
end
