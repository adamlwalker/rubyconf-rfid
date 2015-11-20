class CreateMusics < ActiveRecord::Migration
  def self.up
    create_table :musics do |t|
      t.string :name
      t.string :filename
      t.timestamps
    end
  end

  def self.down
    drop_table :musics
  end
end
