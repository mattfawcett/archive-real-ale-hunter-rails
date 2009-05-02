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

ActiveRecord::Schema.define(:version => 20090502115001) do

  create_table "pubs", :force => true do |t|
    t.decimal  "lat",             :precision => 20, :scale => 20
    t.decimal  "lon",             :precision => 20, :scale => 20
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
  end

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
