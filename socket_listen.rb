require 'socket' 

 door = TCPSocket.new 'speedwayr-10-4e-fa.local', 14150
while rfid = door.gets 
      puts rfid
end 