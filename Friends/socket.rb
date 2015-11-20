# This file was used at United Silver Spring Rubyists
# You can find USSR on Meetup.org

require 'socket'
require 'audite'

READER_HOSTNAME = 'speedwayr-10-4e-fa.local'
READER_PORT = 14150
 
s = TCPSocket.open(READER_HOSTNAME, READER_PORT)
 while true
  line = s.gets
  print line 
   if line.chomp == '35E0170102000000008A7005'
   	  player = Audite.new
      player.load('evan.mp3')
 	  player.start_stream
   end
   if line.chomp == '35E0170102000000008A7000'
     `open http://www.meetup.com/United-Silver-Spring-Ruby/`
   end
   if line.chomp == '35E0170102000000008A700C'
   	`say 'Thank you for letting me speak today! It was a great honor.'`
   end
end
