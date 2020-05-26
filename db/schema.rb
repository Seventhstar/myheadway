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

ActiveRecord::Schema.define(version: 20200526200139) do

  create_table "attentions", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.text "description"
    t.string "src_url"
    t.string "img_url"
    t.integer "attn_cat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "actual"
    t.integer "author_id"
  end

  create_table "attn_cats", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "img_url"
    t.text "annotation"
    t.integer "order"
  end

  create_table "claims", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.integer "user_id"
    t.boolean "reached"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "denials", force: :cascade do |t|
    t.string "name", limit: 255
    t.date "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "docs", force: :cascade do |t|
    t.string "name"
    t.integer "doc_type_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feelings", force: :cascade do |t|
    t.text "content"
    t.date "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "actual"
  end

  create_table "priorities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_suggestions", force: :cascade do |t|
    t.string "term", limit: 255
    t.integer "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statements", force: :cascade do |t|
    t.integer "author_id"
    t.string "source", limit: 255
    t.string "theme", limit: 255
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "book_id"
    t.boolean "isTip"
    t.string "image_url"
  end

  create_table "statementstags", force: :cascade do |t|
    t.integer "statement_id"
    t.integer "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "target_days", force: :cascade do |t|
    t.boolean "checked"
    t.integer "target_id"
    t.integer "day"
    t.integer "month"
    t.integer "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "state"
    t.integer "value"
  end

  create_table "target_groups", force: :cascade do |t|
    t.integer "target_id"
    t.integer "tgroup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "targets", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "parent_id"
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "negative"
  end

  create_table "task_cats", force: :cascade do |t|
    t.string "name"
    t.string "code1c"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code1c"], name: "index_task_cats_on_code1c"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.string "guid_1c"
    t.integer "task_cat_id"
    t.integer "priority_id"
    t.date "start_date"
    t.boolean "fixed"
    t.boolean "upd_1c"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid_1c"], name: "index_tasks_on_guid_1c"
    t.index ["task_cat_id"], name: "index_tasks_on_task_cat_id"
  end

  create_table "tgroups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "negative"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
