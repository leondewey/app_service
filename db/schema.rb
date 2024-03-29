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

ActiveRecord::Schema.define(version: 20141110030245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: true do |t|
    t.string   "name",       limit: 25
    t.integer  "project_id"
    t.string   "repo"
    t.string   "platform"
    t.string   "ci"
    t.boolean  "database",              default: false, null: false
    t.text     "config"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile"
  end

  add_index "apps", ["name"], name: "index_apps_on_name", using: :btree
  add_index "apps", ["project_id"], name: "index_apps_on_project_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "org"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "project_id"
    t.integer  "person_id"
    t.boolean  "write",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["person_id"], name: "index_permissions_on_person_id", using: :btree
  add_index "permissions", ["project_id"], name: "index_permissions_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
