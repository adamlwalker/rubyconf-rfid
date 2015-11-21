#!/usr/bin/env ruby

class Betty
 require './setup.rb'
  def initialize(ip='speedwayr-10-4e-fa.local',port=14150)
   puts "Watching the door for betty"
   door = TCPSocket.new ip, port
   while rfid = door.gets 
    logBetty(rfid.chomp) if rfid.length > 2        
   end 
  end

  def duration
    str = ""
    TimeDifference.between(@start_time, Time.now).in_general.each {|type,count|
      str << "#{count} #{type} " if count > 0
    }
    str
  end

  def bettyIsOut
    @out = true
    $client.update("@acontius I'm outside please don't forget #{$messages.sample}")
    @start_time = Time.now
  end

  def bettyIsIn
    @out = false
    $client.update("@acontius Thanks for letting in! I was outside for #{duration}!")
  end

  def logBetty(rfid)
   return if rfid != $betty 
    @out ? bettyIsIn : bettyIsOut
  end
end

Betty.new
