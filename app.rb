require 'json'
require 'sinatra'
require 'sinatra/activerecord'
require './config/database'

class App < Sinatra::Base
  get '/sinatra' do
    'Hello Word'
  end
end