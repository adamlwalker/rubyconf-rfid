# Scratch file while working on Betty app

require 'twitter'
require 'active_support/all'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

#client.update("RFID Tag Detected: @BettyPittweiler is inside!")

now = Time.now

puts now

counter = 1
loop do
  if Time.now < now + 1.minute 
    next
  else
    puts "counting another minute"
  end
  counter += 1
  break if counter > 60
end
