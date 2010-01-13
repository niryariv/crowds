class AddLastModifiedToFeeds < ActiveRecord::Migration
  def self.up
    remove_column :feeds, :last_read_at
    add_column    :feeds, :last_modified, :string, :default => ''
  end

  def self.down
    remove_column :feeds, :last_modified
    add_column    :feeds, :last_read_at, :timestamp
  end
end
