class Fridge < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :item
  validates_presence_of :rfid
  validates_presence_of :barcode




end
