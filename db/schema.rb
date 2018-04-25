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

ActiveRecord::Schema.define(version: 20180424234937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airlines", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "iata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iata"], name: "index_airlines_on_iata"
    t.index ["name"], name: "index_airlines_on_name"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "iata", null: false
    t.string "name", null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_cities_on_active"
    t.index ["name"], name: "index_cities_on_name"
  end

  create_table "offers", id: :serial, force: :cascade do |t|
    t.integer "offer_type"
    t.integer "discount_type"
    t.string "name"
    t.string "from_google_place_id"
    t.string "to_google_place_id"
    t.integer "airline_id"
    t.boolean "is_direct", default: true
    t.integer "transfers_count"
    t.datetime "date_from"
    t.datetime "date_to"
    t.datetime "date_end"
    t.integer "discount_rate"
    t.text "description"
    t.integer "status", default: 0, null: false
    t.integer "user_id"
    t.float "price"
    t.string "price_currency", default: "RUB"
    t.boolean "two_sides", default: false, null: false
    t.integer "flight_number"
    t.string "gate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airline_id"], name: "index_offers_on_airline_id"
    t.index ["date_from"], name: "index_offers_on_date_from"
    t.index ["date_to"], name: "index_offers_on_date_to"
    t.index ["flight_number"], name: "index_offers_on_flight_number"
    t.index ["status"], name: "index_offers_on_status"
    t.index ["two_sides"], name: "index_offers_on_two_sides"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "transfers", id: :serial, force: :cascade do |t|
    t.integer "offer_id", null: false
    t.string "google_place_id"
    t.integer "airline_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airline_id"], name: "index_transfers_on_airline_id"
    t.index ["offer_id"], name: "index_transfers_on_offer_id"
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.integer "role", default: 0
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "transfers", "airlines"
  add_foreign_key "transfers", "offers"
  add_foreign_key "transfers", "users"
end
