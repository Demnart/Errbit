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
