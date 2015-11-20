class AddFieldsToClothing < ActiveRecord::Migration
  def self.up
    change_table :clothings do |t|
      t.string :rfid
    end
  end

  def self.down
    change_table :clothings do |t|
      t.remove :rfid
    end
  end
end
