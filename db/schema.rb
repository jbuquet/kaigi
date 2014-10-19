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

ActiveRecord::Schema.define(version: 20141019144543) do

  create_table "action_items", force: true do |t|
    t.text     "action"
    t.integer  "retrospective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "votes",             default: 0
    t.integer  "retrospective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "initial_sticky_id"
  end

  create_table "retrospectives", force: true do |t|
    t.string   "name"
    t.text     "public_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_status_id"
    t.integer  "max_votes",         default: 5
  end

  create_table "statuses", force: true do |t|
    t.string   "status_type"
    t.integer  "estimated_duration"
    t.integer  "duration"
    t.integer  "retrospective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
  end

  create_table "stickies", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "retrospective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "sticky_type"
  end

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "color"
    t.integer "retrospective_id"
    t.integer "used_votes",       default: 0
  end

end
