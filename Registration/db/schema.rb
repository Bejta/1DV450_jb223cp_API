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

ActiveRecord::Schema.define(version: 20160607222457) do

  create_table "clients", force: :cascade do |t|
    t.string   "apikey",                                 null: false
    t.string   "name",                                   null: false
    t.string   "description", limit: 500,                null: false
    t.string   "url"
    t.boolean  "active",                  default: true, null: false
    t.integer  "user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id"

  create_table "creators", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  #add_index "positions", ["pub_id"], name: "index_positions_on_pub_id"

  create_table "pubs", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description", null: false
    t.integer  "rating",      null: false
    t.integer  "creator_id"
    t.integer  "position_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pubs_tags", id: false, force: :cascade do |t|
    t.integer "pub_id"
    t.integer "tag_id"
  end

  add_index "pubs_tags", ["pub_id"], name: "index_pubs_tags_on_pub_id"
  add_index "pubs_tags", ["tag_id"], name: "index_pubs_tags_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "username",                        null: false
    t.string   "password_digest",                 null: false
    t.boolean  "admin",           default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
