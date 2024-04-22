# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_22_014647) do
  create_table "active_settings", charset: "utf8", force: :cascade do |t|
    t.string "key", limit: 50, null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_active_settings_on_key", unique: true
  end

  create_table "scripts", charset: "utf8", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "content"
    t.string "external_url"
  end

  create_table "sessions", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "expiration", precision: nil
    t.string "token", limit: 64, null: false
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "fk_rails_758836b4f0"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "login", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "salt", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "website_scripts", charset: "utf8", force: :cascade do |t|
    t.bigint "website_id", null: false
    t.bigint "script_id", null: false
    t.string "path"
    t.index ["script_id", "website_id"], name: "index_website_scripts_on_script_id_and_website_id", unique: true
    t.index ["website_id"], name: "index_website_scripts_on_website_id"
  end

  create_table "websites", charset: "utf8", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "domain", limit: 100, null: false
    t.integer "port", limit: 2, unsigned: true
    t.string "protocol", limit: 5
  end

  add_foreign_key "sessions", "users"
  add_foreign_key "website_scripts", "scripts"
  add_foreign_key "website_scripts", "websites"
end
