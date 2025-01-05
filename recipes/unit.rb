systemd_unit 'errbit.service' do
    content({ Unit: {
              Description: 'errbit',
              Requires: 'network.target',
            },
            Service: {
              Type: 'simple',
              User: 'root',
              Group: 'root',
              WorkingDirectory: '/errbit',
              ExecStart: "/bin/bash -lc 'source /etc/profile.d/rvm.sh && PORT=3000 bundle exec puma -C config/puma.default.rb'",
              Restart: 'always',
            },
            Install: {
              WantedBy: 'multi-user.target',
            } })
    action [:create, :enable]
  end
  
  systemd_unit 'errbit' do
    action [:start, :enable]
  end

