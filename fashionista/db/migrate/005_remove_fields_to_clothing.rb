class RemoveFieldsToClothing < ActiveRecord::Migration
  def self.up
    change_table :clothings do |t|
      t.remove :type
    end
  end

  def self.down
    change_table :clothings do |t|
      t.integer :type
    end
  end
end
