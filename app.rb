require 'json'
require 'sinatra'
require 'sinatra/activerecord'
require './config/database'

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base
  get '/app' do
    'Hello world Sinatra!'   
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
      "source": "Faq Bot",
      "data": {
        "facebook": {
          "attachment": {
            "type": "template",
            "payload": {
              "template_type": "list",
              "elements": [
                {
                  "title": "Classic T-Shirt Collection",
                  "image_url": "https://peterssendreceiveapp.ngrok.io/img/collection.png",
                  "subtitle": "See all our colors",
                  "default_action": {
                    "type": "web_url",
                    "url": "https://peterssendreceiveapp.ngrok.io/shop_collection",
                    "webview_height_ratio": "tall"
                  },
                  "buttons": [
                    {
                      "title": "View",
                      "type": "web_url",
                      "url": "https://peterssendreceiveapp.ngrok.io/collection",
                      "messenger_extensions": true,
                      "webview_height_ratio": "tall",
                      "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
                    }
                  ]
                }
              ]
            }
          }
        }
      }
    }.to_json
  end
end