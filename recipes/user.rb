group node['user']['name'] do
  gid node['user']['gid']
  action :create
end

user node['user']['name'] do
  uid node['user']['uid']
  gid node['user']['gid']
  home  node['user']['path']
  shell node['user']['shell']
  password node['user']['password']
  manage_home true
  action [:create, :modify]
end
