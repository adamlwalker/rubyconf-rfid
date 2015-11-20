class CreateClothings < ActiveRecord::Migration
  def self.up
    create_table :clothings do |t|
      t.string :name
      t.text :description
      t.integer :type
      t.datetime :seen
      t.timestamps
    end
  end

  def self.down
    drop_table :clothings
  end
end
