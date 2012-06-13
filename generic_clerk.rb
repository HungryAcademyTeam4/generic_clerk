require 'redis'
require 'active_record'
require '../app/models/YOUR_MODEL_HERE'

@redis = Redis.new(:host => '127.0.0.1', :port => 6379)
 ActiveRecord::Base.establish_connection(
   adapter: 'mysql2',
  encoding: 'utf8',
  database: 'YOUR_DATABASE_HERE',
  username: 'root',
  password: 'databucket2'
 )

class Message < ActiveRecord::Base
  attr_accessible :chat_room_id, :content, :user_name, :user_id, :chatbot_message_id
end

@redis = Redis.new(host: '127.0.0.1', port: 6379)

@redis.subscribe('conquerapp') do |on|
  on.message do |channel, message|
    parsed = JSON.parse(message)["msg"]["data"]
    message_contents = { chat_room_id:       parsed["chat_room_id"],
                         content:            parsed["content"],
                         user_id:            parsed["user_id"],
                         chatbot_message_id: parsed["id"],
                         user_name:          parsed["user_name"] }
    
    # YOUR PAYLOAD GOES HERE
  end
end