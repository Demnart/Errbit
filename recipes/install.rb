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
    rvm pkg install openssl
    rvm install ruby-2.7.6 --with-openssl-dir=/usr/local/rvm/usr
  EOF
end

bash 'install dependencies' do
  code <<-EOF
  source /etc/profile.d/rvm.sh && gem install libv8-node --version 16.10.00
  mkdir -p /usr/local/rvm/gems/ruby-2.7.6/gems/libv8-node-16.10.0.0-x86_64-linux-musl/vendor/v8/x86_64-linux/libv8/obj/
  cp /usr/local/rvm/gems/ruby-2.7.6/gems/libv8-node-16.10.0.0-x86_64-linux-musl/vendor/v8/x86_64-linux-musl/libv8/obj/libv8_monolith.a /usr/local/rvm/gems/ruby-2.7.6/gems/libv8-node-16.10.0.0-x86_64-linux-musl/vendor/v8/x86_64-linux/libv8/obj/
  source /etc/profile.d/rvm.sh && gem install mini_racer --version 0.6.3 --platform x86_64-linux
  EOF
end

bash 'errbit install' do
  cwd '/errbit'
  code <<-EOF
  source /etc/profile.d/rvm.sh && bundle install
  source /etc/profile.d/rvm.sh && bundle exec rake errbit:bootstrap
  source /etc/profile.d/rvm.sh && bundle exec rails server -d
  EOF
end
