require_relative '../app.rb'
require 'rspec'
require 'shoulda-matchers'
require 'rack/test'
require 'ffaker'
require 'pg_search'

Dir["./spec/support/**/*.rb"].each {|file| require file}
Dir["./app/services/**/*.rb"].each {|file| require file}
Dir["./app/models/**/*.rb"].each {|file| require file}

set :environment, :test

module RSpecMixin 
  include Rack::Test::Methods
  def app
    App
  end
end


Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :active_record
    with.library :active_model
    # with.library :action_controller
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
  ActiveRecord::Base.logger = nil unless ENV['LOG'] == true
end