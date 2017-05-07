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

ActiveRecord::Schema.define(version: 20170506235802) do

  create_table "assets", force: :cascade do |t|
    t.integer "user_id"
    t.text    "name"
    t.text    "description"
    t.text    "file_upload"
    t.text    "created_at",   null: false
    t.text    "updated_at",   null: false
    t.integer "folder_id"
    t.        "file_size"
    t.        "content_type"
    t.index ["folder_id"], name: "index_assets_on_folder_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shared_folders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "shared_email"
    t.integer  "shared_user_id"
    t.integer  "folder_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["folder_id"], name: "index_shared_folders_on_folder_id"
    t.index ["shared_user_id"], name: "index_shared_folders_on_shared_user_id"
    t.index ["user_id"], name: "index_shared_folders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
