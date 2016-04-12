require "sinatra"
require "sinatra/reloader" if development?
require "rest-client"
require "json"
require_relative "const.rb"
require_relative "weather.rb"

get "/" do
  "Hello, world!"
end

post "/callback" do
  line_mes = JSON.parse(request.body.read)["result"][0]
  message = parseWeather(line_mes["content"]["text"])
  contents = {
    contentType: CONTENT_TEXT,
    toType: 1,
    text: message}
  post_params = {
    to: [line_mes["content"]["from"]], 
    toChannel: TO_CHANNEL_ID, 
    eventType: SEND_MES, 
    content: contents
  }
  headers = {
    "Content-Type": "application/json; charser=UTF-8",
    "X-Line-ChannelID": CHANNEL_ID, 
    "X-Line-ChannelSecret": CHANNEL_SECRET,
    "X-Line-Trusted-User-With-ACL": CHANNEL_MID
  }
  
  RestClient.proxy = FIXIE_URL
  # HTTP
  response = RestClient.post(ENDPOINT, post_params.to_json, headers)
end
