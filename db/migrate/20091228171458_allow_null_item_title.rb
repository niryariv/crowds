class AllowNullItemTitle < ActiveRecord::Migration
  def self.up
     execute "ALTER TABLE items MODIFY title varchar(255) null"
  end

  def self.down
     execute "ALTER TABLE items MODIFY title varchar(255) not null"
  end
end
