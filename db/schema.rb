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

ActiveRecord::Schema.define(version: 20180511170254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "airlines", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "iata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iata"], name: "index_airlines_on_iata"
    t.index ["name"], name: "index_airlines_on_name"
  end

  create_table "airports", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_en", null: false
    t.bigint "city_id", null: false
    t.string "iata", null: false
    t.boolean "flightable", default: false, null: false
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_airports_on_city_id"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "iata", null: false
    t.string "name", null: false
    t.boolean "active", default: false, null: false
    t.integer "country_id", null: false
    t.string "name_en", null: false
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_cities_on_active"
    t.index ["country_id"], name: "index_cities_on_country_id"
    t.index ["name"], name: "index_cities_on_name"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_en"
    t.text "desc"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "continents", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "iata", null: false
    t.string "name", null: false
    t.string "name_en", null: false
    t.text "desc"
    t.bigint "continent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["continent_id"], name: "index_countries_on_continent_id"
  end

  create_table "free_directions", force: :cascade do |t|
    t.integer "origin_id", null: false
    t.integer "destination_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["origin_id", "destination_id"], name: "index_free_directions_on_origin_id_and_destination_id", unique: true
  end

  create_table "images_countries_rectangulars", force: :cascade do |t|
    t.bigint "country_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_images_countries_rectangulars_on_country_id"
  end

  create_table "images_countries_squares", force: :cascade do |t|
    t.bigint "country_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_images_countries_squares_on_country_id"
  end

  create_table "offer_collections", force: :cascade do |t|
    t.bigint "offer_id", null: false
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_offer_collections_on_collection_id"
    t.index ["offer_id", "collection_id"], name: "index_offer_collections_on_offer_id_and_collection_id", unique: true
    t.index ["offer_id"], name: "index_offer_collections_on_offer_id"
  end

  create_table "offer_tags", force: :cascade do |t|
    t.bigint "offer_id", null: false
    t.bigint "tag_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id", "tag_id"], name: "index_offer_tags_on_offer_id_and_tag_id", unique: true
    t.index ["offer_id"], name: "index_offer_tags_on_offer_id"
    t.index ["tag_id"], name: "index_offer_tags_on_tag_id"
    t.index ["user_id"], name: "index_offer_tags_on_user_id"
  end

  create_table "offers", id: :serial, force: :cascade do |t|
    t.integer "offer_type"
    t.integer "discount_type"
    t.string "name"
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
    t.integer "origin_id"
    t.integer "destination_id"
    t.integer "from_airport_id"
    t.integer "to_airport_id"
    t.integer "visits_count", default: 0, null: false
    t.string "name_auto"
    t.integer "quality", default: 0, null: false
    t.json "statistic", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "images_countries_square_id"
    t.bigint "images_countries_rectangular_id"
    t.index ["airline_id"], name: "index_offers_on_airline_id"
    t.index ["date_from"], name: "index_offers_on_date_from"
    t.index ["date_to"], name: "index_offers_on_date_to"
    t.index ["destination_id"], name: "index_offers_on_destination_id"
    t.index ["flight_number"], name: "index_offers_on_flight_number"
    t.index ["from_airport_id"], name: "index_offers_on_from_airport_id"
    t.index ["images_countries_rectangular_id"], name: "index_offers_on_images_countries_rectangular_id"
    t.index ["images_countries_square_id"], name: "index_offers_on_images_countries_square_id"
    t.index ["origin_id"], name: "index_offers_on_origin_id"
    t.index ["status"], name: "index_offers_on_status"
    t.index ["to_airport_id"], name: "index_offers_on_to_airport_id"
    t.index ["two_sides"], name: "index_offers_on_two_sides"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "transfers", id: :serial, force: :cascade do |t|
    t.integer "offer_id", null: false
    t.string "google_place_id"
    t.integer "airline_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.index ["airline_id"], name: "index_transfers_on_airline_id"
    t.index ["city_id"], name: "index_transfers_on_city_id"
    t.index ["offer_id"], name: "index_transfers_on_offer_id"
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", default: 0
    t.string "password_digest", null: false
    t.string "image"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "images_countries_rectangulars", "countries"
  add_foreign_key "images_countries_squares", "countries"
  add_foreign_key "offer_tags", "offers"
  add_foreign_key "offer_tags", "tags"
  add_foreign_key "offer_tags", "users"
  add_foreign_key "tags", "users"
end
