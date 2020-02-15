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

ActiveRecord::Schema.define(version: 2020_02_15_102549) do

  create_table "categorie_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categorie_items_on_category_id"
    t.index ["item_id"], name: "index_categorie_items_on_item_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "text"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "condition_id"
    t.bigint "deliverycost_id"
    t.bigint "Prefecture_id"
    t.bigint "day_id"
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Prefecture_id"], name: "index_items_on_Prefecture_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["condition_id"], name: "index_items_on_condition_id"
    t.index ["day_id"], name: "index_items_on_day_id"
    t.index ["deliverycost_id"], name: "index_items_on_deliverycost_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "lastname", null: false
    t.string "firstname", null: false
    t.string "zipcode", null: false
    t.bigint "pref_id"
    t.string "city", null: false
    t.string "address", null: false
    t.string "buildingname"
    t.string "phone"
    t.string "lastname_kana", null: false
    t.string "firstname_kana", null: false
    t.bigint "birthyear_id"
    t.bigint "birthmonth_id"
    t.bigint "birthday_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birthday_id"], name: "index_users_on_birthday_id"
    t.index ["birthmonth_id"], name: "index_users_on_birthmonth_id"
    t.index ["birthyear_id"], name: "index_users_on_birthyear_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["pref_id"], name: "index_users_on_pref_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categorie_items", "categories"
  add_foreign_key "categorie_items", "items"
  add_foreign_key "images", "items"
end
