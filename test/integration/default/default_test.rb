mongodb_service=input('mongodb_service')
mongodb_port=input('mongodb_port')
errbit_service=input('errbit_service')
errbit_port=input('errbit_port')
ruby_path=input('ruby_path')
default_user=input('default_user')


describe systemd_service( mongodb_service ) do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe systemd_service( errbit_service ) do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
end

describe port( mongodb_port ) do
  it { should be_listening }
end

describe port( errbit_port ) do
  it { should be_listening }
end

describe directory ( ruby_path ) do
  it { should exist }
  it { should be_directory }
end

describe user( default_user ) do
it { should exist}
its ( 'uid' ) { should eq 1000 }
its ( 'gid' ) { should eq 1000 }
its ( 'group' ) { should eq default_user }
end

