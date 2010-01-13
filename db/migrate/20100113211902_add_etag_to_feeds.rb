class AddEtagToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :etag, :string, :default => ''
  end

  def self.down
    remove_column :feeds, :etag
  end
end
