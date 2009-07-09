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

ActiveRecord::Schema.define(:version => 20090709164636) do

  create_table "beers", :force => true do |t|
    t.string   "name"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.decimal  "lat",             :precision => 20, :scale => 20
    t.decimal  "lng",             :precision => 20, :scale => 20
    t.string   "website"
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
    t.string   "pints"
    t.decimal  "memory_lat",  :precision => 20, :scale => 20
    t.decimal  "memory_lon",  :precision => 20, :scale => 20
    t.integer  "memory_zoom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
