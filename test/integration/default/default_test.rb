describe systemd_service('mongod') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe systemd_service('errbit') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
end

describe port('27017') do
  it { should be_listening }
end

describe port('3000') do
  it { should be_listening }
end
