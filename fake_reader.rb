# Fake RFID reader for testing apps

require 'socket'

server = TCPServer.new 14150 # Server bind to port 2000
loop do
  client = server.accept    # Wait for a client to connect
  puts "Enter RFID tag to send to smartTrashCan: "
  client.puts gets.chomp
end
