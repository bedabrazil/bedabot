defaults = {
    adapter: 'postgresql',
    encoding: 'utf8',
    database: 'bedabot_test',
    pool: 5,
    username: 'postgres',
    host: 'postgres'
  }
configure :test do
  set :database, defaults
end

configure :development do
  set :database, defaults.merge({database: 'bedabot_development'})
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///postgres/bedabot_production')

  set :database, defaults.merge({
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  })
  
end