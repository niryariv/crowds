class AddNormalizedIndex < ActiveRecord::Migration
  def self.up
      add_index     :items, :normalized
  end

  def self.down
      remove_index  :items, :normalized
  end
end
