class AddUpdatedAtToFeeds < ActiveRecord::Migration
  def self.up
    add_column  :feeds, :updated_at, :datetime
    add_index   :feeds, :updated_at
  end

  def self.down
    remove_index  :feeds, :updated_at
    remove_column :feeds, :updated_at
  end
end
