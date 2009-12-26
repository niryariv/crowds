class AddFailCountToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :fail_count, :integer, :default => 0
  end

  def self.down
    remove_column :feeds, :fail_count
  end
end
