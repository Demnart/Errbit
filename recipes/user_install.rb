package 'git' do
  action :install
end

git 'errbit' do
  user node['user']['name']
  group node['user']['name']
  repository node['errbit']['repo']
  destination node['errbit']['destination']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
end

bash 'rvm download' do
  user node['user']['name']
  group node['user']['name']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
  cwd node['user']['path']
  code <<-EOF
   gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
   curl -sSL https://get.rvm.io -o rvm.sh
   cat rvm.sh | bash -s stable
   source #{node['user']['path']}/.rvm/scripts/rvm
  EOF
  not_if { ::File.exist?("#{node['user']['path']}/.rvm/bin/rvm") }
end

bash ['rvm install openssl package'] do
  code <<-EOF
  #{node['user']['path']}/.rvm/bin/rvm pkg install openssl
  EOF
  not_if { ::File.exist?("#{node['rvm']['openssl']['path']}") }
end

bash ['rvm install ruby-2.7.6'] do
  user node['user']['name']
  group node['user']['name']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
  cwd node['user']['path']
  code <<-EOF
  #{node['rvm']['bin']} install ruby-2.7.6 --with-openssl-dir=#{node['user']['path']}/.rvm/usr/
  EOF
  not_if 'rvm list | grep ruby-2.7.6'
end

bash ['gem install libv8-node'] do
  user node['user']['name']
  group node['user']['name']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
  cwd node['user']['path']
  code <<-EOF
  wget https://rubygems.org/downloads/libv8-node-16.10.0.0-x86_64-linux.gem -P /tmp
  #{node['rvm']['wrapper']['gem']} install /tmp/libv8-node-16.10.0.0-x86_64-linux.gem
  EOF
  not_if { ::File.exist?("#{node['user']['path']}/.rvm/gems/ruby-2.7.6/gems/libv8-node-16.10.0.0-x86_64-linux/vendor/v8/x86_64-linux/libv8/obj/libv8_monolith.a") }
end

bash ['gem install mini_racer'] do
  user node['user']['name']
  group node['user']['name']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
  cwd node['user']['path']
  code <<-EOF
 #{node['rvm']['wrapper']['gem']} install mini_racer --version 0.6.3 --platform x86_64-linux
 EOF
  not_if { ::File.exist?("#{node['user']['path']}/.rvm/gems/ruby-2.7.6/gems/mini_racer-0.6.3/bin") }
end

template "#{node['errbit']['destination']}/.env" do
  source 'errbit.erb'
  owner node['user']['name']
  group node['user']['name']
  mode '0644'
end

bash ['bundle install'] do
  user node['user']['name']
  group node['user']['name']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
  cwd node['errbit']['destination']
  code <<-EOF
 #{node['rvm']['wrapper']['bundle']} install
 EOF
end

bash ['bundle bootstrap'] do
  user node['user']['name']
  group node['user']['name']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
  cwd node['errbit']['destination']
  code <<-EOF
 #{node['rvm']['wrapper']['bundle']} exec rake errbit:bootstrap
 EOF
end

bash ['bundle start rails'] do
  user node['user']['name']
  group node['user']['name']
  environment 'HOME' => node['user']['path'], 'USER' => node['user']['name']
  cwd node['errbit']['destination']
  code <<-EOF
#{node['rvm']['wrapper']['bundle']} exec rails server -d --binding="#{node['errbit']['default']['address']}"
EOF
end
