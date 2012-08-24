# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120720153411) do

  create_table "beers", :force => true do |t|
    t.string   "name"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "breweries", :force => true do |t|
    t.string "brewery_name"
  end

  create_table "edits", :force => true do |t|
    t.string  "table_name"
    t.string  "column_name"
    t.text    "old_value"
    t.text    "new_value"
    t.integer "user"
    t.string  "date",        :limit => 20
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "pub_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "lat",               :limit => 50, :default => "0.000000", :null => false
    t.string   "lon",               :limit => 50, :default => "0.000000", :null => false
    t.integer  "zoom",                            :default => 0,          :null => false
    t.text     "description",                                             :null => false
    t.string   "name",                            :default => "",         :null => false
    t.string   "address_1"
    t.string   "address_2",                       :default => "",         :null => false
    t.string   "town",                            :default => "",         :null => false
    t.string   "post_code",                       :default => "",         :null => false
    t.string   "telephone",                       :default => "",         :null => false
    t.string   "website",                         :default => "",         :null => false
    t.string   "rating",                          :default => "",         :null => false
    t.string   "number_of_ratings",               :default => "",         :null => false
    t.string   "number_of_pumps",   :limit => 10, :default => "",         :null => false
    t.integer  "added_by"
    t.integer  "gbg"
    t.datetime "date_added"
    t.string   "county"
    t.integer  "cask_marque",                     :default => 0,          :null => false
  end

  create_table "pub_beers", :force => true do |t|
    t.integer "pub_id"
    t.integer "beer_id"
  end

  create_table "pubs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "town"
    t.string   "post_code"
    t.string   "telephone"
    t.integer  "number_of_pumps"
    t.integer  "user_id"
    t.boolean  "gbg"
    t.boolean  "cask_marque",                                     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat",             :precision => 15, :scale => 12
    t.decimal  "lng",             :precision => 15, :scale => 12
    t.string   "website"
    t.string   "slug"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "pub_id"
    t.integer  "user_id"
    t.integer  "beer_quality"
    t.integer  "beer_selection"
    t.integer  "atmosphere"
    t.integer  "price"
    t.integer  "overall_option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :primary_key => "serial", :force => true do |t|
    t.string "session_id"
    t.string "logged_in",   :limit => 1, :default => "", :null => false
    t.string "user_serial"
    t.string "ip_address"
    t.string "expires"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "level"
    t.integer  "pints",                                            :default => 0, :null => false
    t.decimal  "memory_lat",       :precision => 20, :scale => 20
    t.decimal  "memory_lon",       :precision => 20, :scale => 20
    t.integer  "memory_zoom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_username"
  end

  create_table "visit_beers", :force => true do |t|
    t.string "visit_id", :limit => 10
    t.string "beer_id",  :limit => 10
  end

  create_table "visits", :force => true do |t|
    t.integer  "pub_id"
    t.integer  "user_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tweet_id"
    t.string   "tweet_username"
  end

end
