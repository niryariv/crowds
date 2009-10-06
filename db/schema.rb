# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "crowds", :force => true do |t|
    t.string  "title",   :null => false
    t.integer "user_id", :null => false
  end

  add_index "crowds", ["user_id"], :name => "user_id"

  create_table "crowds_bak", :force => true do |t|
    t.string  "title",   :null => false
    t.integer "user_id", :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "title",        :null => false
    t.string   "url",          :null => false
    t.string   "home_url",     :null => false
    t.datetime "created_at",   :null => false
    t.datetime "last_read_at"
  end

  add_index "feeds", ["url"], :name => "url", :unique => true

  create_table "items", :force => true do |t|
    t.integer  "feed_id",    :null => false
    t.string   "title",      :null => false
    t.text     "url",        :null => false
    t.datetime "created_at", :null => false
    t.integer  "source_id"
  end

  add_index "items", ["created_at"], :name => "items_created_at_index"
  add_index "items", ["feed_id", "url"], :name => "feed_id_2", :unique => true
  add_index "items", ["feed_id"], :name => "feed_id"

  # create_table "items_old", :force => true do |t|
  #   t.integer  "feed_id",    :null => false
  #   t.string   "title",      :null => false
  #   t.text     "url",        :null => false
  #   t.datetime "created_at", :null => false
  # end
  # 
  # add_index "items_old", ["created_at"], :name => "items_created_at_index"
  # add_index "items_old", ["feed_id"], :name => "feed_id"

  create_table "ownerships", :force => true do |t|
    t.integer "feed_id",  :null => false
    t.integer "crowd_id", :null => false
  end

  # add_index "ownerships", ["crowd_id"], :name => "user_id"
  # add_index "ownerships", ["feed_id", "crowd_id"], :name => "feed_id_2", :unique => true
  # add_index "ownerships", ["feed_id"], :name => "feed_id"

  create_table "tags", :force => true do |t|
    t.string   "url",        :limit => 256, :null => false
    t.string   "tags",       :limit => 256, :null => false
    t.datetime "created_at",                :null => false
  end

  # add_index "tags", ["url"], :name => "url", :unique => true

  create_table "trueurls", :force => true do |t|
    t.string  "host"
    t.boolean "clean"
  end

  add_index "trueurls", ["host"], :name => "host"

  create_table "users", :force => true do |t|
    t.string   "title"
    t.string   "email"
    t.string   "crypted_password",            :limit => 256
    t.string   "salt",                        :limit => 256
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token"
    t.datetime "perishable_token_expires_at"
    t.string   "persistence_token"
  end

  # create_table "users_bak", :force => true do |t|
  #   t.string   "title"
  #   t.string   "email"
  #   t.string   "crypted_password",            :limit => 40
  #   t.string   "salt",                        :limit => 40
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.string   "perishable_token"
  #   t.datetime "perishable_token_expires_at"
  #   t.string   "persistence_token"
  # end

end
