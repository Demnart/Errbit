apt_repository 'mongodb' do
  uri          'https://repo.mongodb.org/apt/ubuntu'
  distribution 'focal/mongodb-org/8.0'
  components   'multiverse'
  key 'https://www.mongodb.org/static/pgp/server-8.0.asc'
end
