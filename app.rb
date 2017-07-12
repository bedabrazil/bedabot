require 'json'
require 'sinatra'
require 'i18n'
require 'sinatra/activerecord'
require './config/database'

I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config/locales', '*.yml').to_s]
Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base
  get '/app' do
    'Hello world, welcome in BedaBot!'   
  end

  post '/webhook' do
    result = JSON.parse(request.body.read)["result"]
    if result["contexts"].present?
      response = InterpretService.call(result["action"], result["contexts"][0]["parameters"])
    else
      response = InterpretService.call(result["action"], result["parameters"])
    end

    content_type :json
    {
      "speech": response,
      "displayText": response,
      "source": "Faq Bot"
    }.to_json
  end
end