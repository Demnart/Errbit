package 'git' do
  action :install
end

package 'gpg' do
  action :install
end

git 'errbit' do
  repository 'https://github.com/errbit/errbit.git'
  revision 'main'
end

bash 'rvm install' do
  code <<-EOF
    gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io -o rvm.sh
    cat rvm.sh | bash -s stable
    source /etc/profile.d/rvm.sh
    #rvm pkg install openssl
    #rvm reinstall ruby 2.7.6 --with-openssl-dir=/usr/local/rvm/usr/
    rvm install ruby-2.7.6
  EOF
end
