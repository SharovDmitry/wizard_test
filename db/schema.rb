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

ActiveRecord::Schema.define(version: 20170626183450) do

  create_table "check_in_dates", force: :cascade do |t|
    t.string "date"
    t.integer "hotel_id"
    t.index ["hotel_id"], name: "index_check_in_dates_on_hotel_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.integer "city_id"
    t.index ["city_id"], name: "index_hotels_on_city_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "city"
    t.string "date"
    t.string "hotel"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
