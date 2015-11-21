require 'socket'
require 'twitter'
require 'active_support/all'
require 'time_difference'

$client = Twitter::REST::Client.new do |config| # Set your twitter API information
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

$betty = '300833B2DDD9014000000000' # set this to your RFID tag

$messages = ['to let me back in','like you did last time','you putz',
  'because you are obsessed with #ruby','or let the cats eat my food']
