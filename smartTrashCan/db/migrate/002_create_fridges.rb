class CreateFridges < ActiveRecord::Migration
  def self.up
    create_table :fridges do |t|
      t.string :item
      t.string :barcode
      t.string :rfid
      t.boolean :onhand, default: true
      t.timestamps
    end
  end

  def self.down
    drop_table :fridges
  end
end
