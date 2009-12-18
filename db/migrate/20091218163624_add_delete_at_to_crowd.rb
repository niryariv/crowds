class AddDeleteAtToCrowd < ActiveRecord::Migration
  def self.up
    add_column :crowds, :delete_at, :timestamp
  end

  def self.down
    remove_column :crowds, :delete_at
  end
end
