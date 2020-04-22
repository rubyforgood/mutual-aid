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

ActiveRecord::Schema.define(version: 2020_04_19_161258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "publish_from"
    t.date "publish_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "name", null: false
    t.string "description"
    t.boolean "display_to_public", default: true, null: false
    t.integer "display_order", default: 10, null: false
    t.boolean "is_created_by_admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["description"], name: "index_categories_on_description"
    t.index ["display_order"], name: "index_categories_on_display_order"
    t.index ["display_to_public"], name: "index_categories_on_display_to_public"
    t.index ["is_created_by_admin"], name: "index_categories_on_is_created_by_admin"
    t.index ["name"], name: "index_categories_on_name"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "communication_logs", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "channel"
    t.datetime "sent_at"
    t.boolean "needs_follow_up"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_communication_logs_on_person_id"
  end

  create_table "community_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "website_url"
    t.string "facebook_url"
    t.string "phone"
    t.string "description"
    t.date "publish_from"
    t.date "publish_until"
    t.boolean "is_created_by_admin", default: true, null: false
    t.boolean "is_approved", default: true, null: false
    t.string "youtube_identifier"
    t.bigint "location_id"
    t.bigint "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags", default: [], array: true
    t.index ["is_approved"], name: "index_community_resources_on_is_approved"
    t.index ["is_created_by_admin"], name: "index_community_resources_on_is_created_by_admin"
    t.index ["location_id"], name: "index_community_resources_on_location_id"
    t.index ["organization_id"], name: "index_community_resources_on_organization_id"
    t.index ["tags"], name: "index_community_resources_on_tags", using: :gin
  end

  create_table "custom_form_questions", force: :cascade do |t|
    t.string "name"
    t.string "input_type"
    t.boolean "is_required"
    t.string "form_type"
    t.string "hint_text"
    t.string "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "option_list", default: [], array: true
  end

  create_table "donations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.float "value"
    t.string "channel"
    t.string "thank_you_sent"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_donations_on_person_id"
  end

  create_table "external_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "website_url"
    t.string "facebook_url"
    t.string "phone"
    t.string "description"
    t.string "youtube_identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags", default: [], array: true
    t.boolean "reviewed", default: false, null: false
    t.date "display_on_website_start"
    t.date "display_on_website_end"
    t.bigint "system_location_id"
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_external_resources_on_organization_id"
    t.index ["system_location_id"], name: "index_external_resources_on_system_location_id"
    t.index ["tags"], name: "index_external_resources_on_tags", using: :gin
  end

  create_table "listings", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "tags", default: [], array: true
    t.integer "state", default: 0
    t.bigint "location_id"
    t.string "name"
    t.string "email"
    t.string "phone"
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

  create_table "matches", force: :cascade do |t|
    t.integer "provider_id"
    t.string "provider_type"
    t.string "receiver_type"
    t.integer "receiver_id"
    t.string "status"
    t.string "notes"
    t.boolean "tentative"
    t.boolean "completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "facebook_url"
    t.string "website_url"
    t.string "phone"
    t.boolean "is_instance_owner"
    t.boolean "has_sms_account"
    t.boolean "has_hosting_account"
    t.boolean "has_mailer_account"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.string "phone_2"
    t.string "email_2"
    t.string "preferred_contact_method"
    t.string "preferred_contact_timeframe"
    t.text "skills"
    t.text "notes"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "position_type"
    t.string "name"
    t.string "description"
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_primary"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_positions_on_organization_id"
    t.index ["person_id"], name: "index_positions_on_person_id"
  end

  create_table "shared_accounts", force: :cascade do |t|
    t.string "name"
    t.string "account_url"
    t.string "username"
    t.string "password_hint"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "system_locations", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "organization_id"
    t.string "location_type"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "county"
    t.string "region"
    t.string "neighborhood"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_system_locations_on_organization_id"
    t.index ["parent_id"], name: "index_system_locations_on_parent_id"
  end

  create_table "system_settings", force: :cascade do |t|
    t.string "exchange_type"
    t.boolean "separate_asks_offers"
    t.boolean "allow_sms"
    t.boolean "community_resources_module"
    t.boolean "announcements_module"
    t.boolean "positions_module"
    t.boolean "donations_module"
    t.boolean "shared_accounts_module"
    t.boolean "chat_module"
    t.text "landing_page_text_what"
    t.text "landing_page_text_who"
    t.text "landing_page_text_how"
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

  add_foreign_key "communication_logs", "people"
  add_foreign_key "community_resources", "locations"
  add_foreign_key "community_resources", "organizations"
  add_foreign_key "donations", "people"
  add_foreign_key "external_resources", "organizations"
  add_foreign_key "external_resources", "system_locations"
  add_foreign_key "listings", "locations"
  add_foreign_key "people", "users"
  add_foreign_key "positions", "organizations"
  add_foreign_key "positions", "people"
  add_foreign_key "system_locations", "organizations"
end
