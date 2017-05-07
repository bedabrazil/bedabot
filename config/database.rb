defaults = {
    adapter: 'postgresql',
    encoding: 'utf8',
    database: 'bedabot_test',
    pool: 5,
    username: 'postgres',
    host: 'postgress'
  }
configure :test do
  set :database, defaults
end

configure :development do
  set :database, defaults.merge({database: 'bedabot_development'})
end

configure :production do
  set :database, defaults.merge({database:'bedabot_production')
end