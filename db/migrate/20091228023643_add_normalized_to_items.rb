class AddNormalizedToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :normalized, :boolean, :default => true
  end

  def self.down
    remove_column :items, :normalized
  end
end
