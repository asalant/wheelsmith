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

ActiveRecord::Schema.define(:version => 20090502045322) do

  create_table "hubs", :force => true do |t|
    t.string   "part_number"
    t.string   "brand"
    t.string   "description"
    t.boolean  "rear"
    t.float    "right_flange_diameter"
    t.float    "right_flange_to_center"
    t.float    "left_flange_diameter"
    t.float    "left_flange_to_center"
    t.integer  "hole_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hubs", ["part_number"], :name => "index_hubs_on_part_number"

  create_table "rims", :force => true do |t|
    t.string   "part_number"
    t.string   "brand"
    t.string   "description"
    t.integer  "size"
    t.float    "erd"
    t.float    "offset"
    t.integer  "hole_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rims", ["part_number"], :name => "index_rims_on_part_number"

  create_table "wheels", :force => true do |t|
    t.integer  "hub_id"
    t.integer  "rim_id"
    t.integer  "spoke_pattern"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wheels", ["hub_id"], :name => "index_wheels_on_hub_id"
  add_index "wheels", ["rim_id"], :name => "index_wheels_on_rim_id"

end
