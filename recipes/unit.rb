systemd_unit 'errbit.service' do
    content({ Unit: {
              Description: 'Run the Errbit app as systemd_unit',
              Requires: 'network.target',
            },
            Service: {
              Type: 'simple',
              User: 'root',
              Group: 'root',
              WorkingDirectory: "#{node['errbit']['destination']}/",
              ExecStart: "/bin/bash -lc 'PORT=#{node['errbit']['default']['port']} #{node['rvm']['wrapper']['bundle']} exec puma -C config/puma.default.rb'",
              Restart: 'always',
            },
            Install: {
              WantedBy: 'multi-user.target',
            } })
    action [:create, :enable, :start]
  end
  
