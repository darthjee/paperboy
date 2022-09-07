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

ActiveRecord::Schema.define(version: 2021_11_12_102101) do

  create_table "scripts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "content"
    t.string "external_url"
  end

  create_table "sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "expiration"
    t.index ["user_id"], name: "fk_rails_758836b4f0"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "login", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "salt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "website_scripts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "website_id", null: false
    t.bigint "script_id", null: false
    t.string "path"
    t.index ["script_id", "website_id"], name: "index_website_scripts_on_script_id_and_website_id", unique: true
    t.index ["website_id"], name: "index_website_scripts_on_website_id"
  end

  create_table "websites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "domain", limit: 100, null: false
    t.integer "port", limit: 2, unsigned: true
    t.string "protocol", limit: 5
  end

  add_foreign_key "sessions", "users"
  add_foreign_key "website_scripts", "scripts"
  add_foreign_key "website_scripts", "websites"
end
