# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_03_230312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

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
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "count_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "denials", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "term"
    t.integer "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sets_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statements", force: :cascade do |t|
    t.integer "author_id"
    t.string "source"
    t.string "theme"
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "book_id"
    t.boolean "isTip"
    t.string "image_url"
  end

  create_table "statementstags", force: :cascade do |t|
    t.integer "statement_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_days", force: :cascade do |t|
    t.boolean "checked"
    t.integer "target_id"
    t.integer "day"
    t.integer "month"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "name"
    t.integer "parent_id"
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "negative"
    t.integer "sets_name_id"
    t.integer "count_name_id"
  end

  create_table "task_cats", force: :cascade do |t|
    t.string "name"
    t.string "code1c"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "img_num"
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
    t.boolean "fixed", default: false
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
