class AddCreatedAtToCrowds < ActiveRecord::Migration
  def self.up
    add_column :crowds, :created_at, :timestamp
  end

  def self.down
    remove_column :crowds, :created_at
  end
end
