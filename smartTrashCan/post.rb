# Scratch file

require 'rest-client'

response = RestClient.post 'http://192.168.0.6:3000/trash', '1,0742676408529' 

puts response.inspect
