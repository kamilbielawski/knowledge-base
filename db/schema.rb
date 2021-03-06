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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150104204008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "resources", force: true do |t|
    t.string   "name",                    null: false
    t.text     "description"
    t.text     "url",                     null: false
    t.integer  "topic_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating",      default: 0
  end

  add_index "resources", ["rating"], name: "index_resources_on_rating", using: :btree
  add_index "resources", ["topic_id"], name: "index_resources_on_topic_id", using: :btree

  create_table "resources_tags", force: true do |t|
    t.integer  "resource_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources_tags", ["resource_id", "tag_id"], name: "index_resources_tags_on_resource_id_and_tag_id", unique: true, using: :btree
  add_index "resources_tags", ["resource_id"], name: "index_resources_tags_on_resource_id", using: :btree
  add_index "resources_tags", ["tag_id"], name: "index_resources_tags_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["name"], name: "index_topics_on_name", unique: true, using: :btree

end
