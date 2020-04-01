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

ActiveRecord::Schema.define(version: 2020_04_01_105929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "external_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "website_url"
    t.string "facebook_url"
    t.string "phone"
    t.string "description"
    t.boolean "display_on_website", default: true, null: false
    t.string "youtube_identifier"
    t.bigint "location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags", default: [], array: true
    t.index ["display_on_website"], name: "index_external_resources_on_display_on_website"
    t.index ["location_id"], name: "index_external_resources_on_location_id"
    t.index ["tags"], name: "index_external_resources_on_tags", using: :gin
  end

  create_table "listings", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "tags", default: [], array: true
    t.integer "state", default: 0
    t.bigint "location_id"
    t.index ["location_id"], name: "index_listings_on_location_id"
    t.index ["tags"], name: "index_listings_on_tags", using: :gin
  end

  create_table "locations", force: :cascade do |t|
    t.string "street_address"
    t.string "city"
    t.string "state", limit: 2
    t.string "zip", limit: 5
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "external_resources", "locations"
  add_foreign_key "listings", "locations"
end
