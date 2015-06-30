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

ActiveRecord::Schema.define(version: 20150630052153) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 100, default: "", null: false
    t.string   "username",        limit: 25
    t.string   "hashed_password", limit: 40
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "admin_users", ["username"], name: "index_admin_users_on_username", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "text",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "ranking",     limit: 4
    t.integer  "category_id", limit: 4
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commenter",  limit: 255
    t.text     "body",       limit: 65535
    t.integer  "article_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "permalink",  limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",    limit: 1,   default: true
    t.integer  "subject_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree
  add_index "pages", ["subject_id"], name: "index_pages_on_subject_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "position",     limit: 4
    t.boolean  "visible",      limit: 1,     default: true
    t.string   "content_type", limit: 255
    t.text     "content",      limit: 65535
    t.integer  "page_id",      limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "sections", ["page_id"], name: "index_sections_on_page_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",    limit: 1,   default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_foreign_key "comments", "articles"
end
