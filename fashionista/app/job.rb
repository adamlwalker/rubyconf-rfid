module Fashionista
  class Job < Padrino::Application
    require 'socket'
    require 'audite'
    include SuckerPunch::Job
    workers 2

    def findtag(line)
      tag = Clothing.find_by(rfid: line)
      return 0 if tag && tag.seen > 60.seconds.ago
      tag ? (tag.update(seen: DateTime.now)) : (return 0)
      tag[:rank]
    end

    def playsong(song)   
        player = Audite.new
        player.load("#{song}.mp3")
        player.start_stream
     end
  
    def listen            
	    rfid = TCPSocket.new 'speedwayr-10-4e-fa.local', 14150
        while line = rfid.gets           
          if line.chomp.length > 2
            tag = findtag(line.chomp)
            Job.new.playsong(tag) unless tag == 0
          end
        end 
    end

  end
end