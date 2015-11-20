class AddRankToClothing < ActiveRecord::Migration
  def self.up
    change_table :clothings do |t|
      t.integer :rank
    end
  end

  def self.down
    change_table :clothings do |t|
      t.integer :rank
    end
  end
end
