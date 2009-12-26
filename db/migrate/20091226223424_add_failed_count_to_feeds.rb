class AddFailedCountToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :failed_count, :integer, :default => 0
  end

  def self.down
    remove_column :feeds, :failed_count
  end
end
