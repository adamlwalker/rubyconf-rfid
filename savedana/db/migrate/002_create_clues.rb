class CreateClues < ActiveRecord::Migration
  def self.up
    create_table :clues do |t|
      t.string :rfid
      t.text :riddle
      t.boolean :found
      t.timestamps
    end
  end

  def self.down
    drop_table :clues
  end
end
