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

ActiveRecord::Schema.define(version: 20180307160819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cuisine_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "type"
    t.string "url"
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_photos_on_place_id"
  end

  create_table "place_cuisine_types", force: :cascade do |t|
    t.bigint "cuisine_type_id"
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_type_id"], name: "index_place_cuisine_types_on_cuisine_type_id"
    t.index ["place_id"], name: "index_place_cuisine_types_on_place_id"
  end

  create_table "place_meal_types", force: :cascade do |t|
    t.bigint "place_id"
    t.bigint "meal_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_type_id"], name: "index_place_meal_types_on_meal_type_id"
    t.index ["place_id"], name: "index_place_meal_types_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "locality"
    t.integer "average_cost_for_two"
    t.string "featured_image"
    t.float "user_rating"
    t.integer "phone_number"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "opening_time"
    t.string "closing_time"
  end

  create_table "places_histories", force: :cascade do |t|
    t.boolean "rejected"
    t.bigint "user_id"
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_places_histories_on_place_id"
    t.index ["user_id"], name: "index_places_histories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "photos", "places"
  add_foreign_key "place_cuisine_types", "cuisine_types"
  add_foreign_key "place_cuisine_types", "places"
  add_foreign_key "place_meal_types", "meal_types"
  add_foreign_key "place_meal_types", "places"
  add_foreign_key "places_histories", "places"
  add_foreign_key "places_histories", "users"
end
