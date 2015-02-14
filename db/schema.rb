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

ActiveRecord::Schema.define(version: 20140622081619) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "denials", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feelings", force: :cascade do |t|
    t.text     "content"
    t.date     "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_suggestions", force: :cascade do |t|
    t.string   "term"
    t.integer  "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statements", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "source"
    t.string   "theme"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
    t.boolean  "isTip"
  end

  create_table "statementstags", force: :cascade do |t|
    t.integer  "statement_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "target_days", force: :cascade do |t|
    t.boolean  "checked"
    t.integer  "target_id"
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
