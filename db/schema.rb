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

ActiveRecord::Schema.define(version: 2020_09_06_172102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "publish_from"
    t.date "publish_until"
    t.boolean "is_approved", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.bigint "person_id"
    t.bigint "match_id"
    t.datetime "sent_at"
    t.boolean "needs_follow_up", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "delivery_status"
    t.string "subject"
    t.bigint "created_by_id", default: 1, null: false
    t.string "body"
    t.boolean "outbound", default: true, null: false
    t.bigint "delivery_method_id", null: false
    t.boolean "auto_generated", default: false
    t.index ["created_by_id"], name: "index_communication_logs_on_created_by_id"
    t.index ["delivery_method_id"], name: "index_communication_logs_on_delivery_method_id"
    t.index ["match_id"], name: "index_communication_logs_on_match_id"
    t.index ["person_id"], name: "index_communication_logs_on_person_id"
  end

  create_table "community_resources", force: :cascade do |t|
    t.bigint "service_area_id"
    t.bigint "location_id"
    t.bigint "organization_id"
    t.string "name"
    t.string "website_url"
    t.string "facebook_url"
    t.string "phone"
    t.string "description"
    t.date "publish_from"
    t.date "publish_until"
    t.boolean "is_created_by_admin", default: true, null: false
    t.boolean "is_approved", default: true, null: false
    t.string "youtube_identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags", default: [], array: true
    t.index ["is_approved"], name: "index_community_resources_on_is_approved"
    t.index ["is_created_by_admin"], name: "index_community_resources_on_is_created_by_admin"
    t.index ["location_id"], name: "index_community_resources_on_location_id"
    t.index ["organization_id"], name: "index_community_resources_on_organization_id"
    t.index ["service_area_id"], name: "index_community_resources_on_service_area_id"
    t.index ["tags"], name: "index_community_resources_on_tags", using: :gin
  end

  create_table "contact_methods", force: :cascade do |t|
    t.string "name"
    t.string "field"
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "icon_class"
    t.index ["enabled"], name: "index_contact_methods_on_enabled"
  end

  create_table "custom_form_questions", force: :cascade do |t|
    t.string "name"
    t.string "input_type"
    t.boolean "is_required", default: true, null: false
    t.string "form_type"
    t.text "option_list", default: [], array: true
    t.string "hint_text"
    t.string "display_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "form_hook"
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

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.boolean "is_from_receiver", default: true, null: false
    t.boolean "completed", default: false, null: false
    t.integer "quality"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_feedbacks_on_match_id"
  end

  create_table "form_questions", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.bigint "custom_form_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["custom_form_question_id"], name: "index_form_questions_on_custom_form_question_id"
    t.index ["form_id"], name: "index_form_questions_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "contribution_type_name"
    t.string "name"
    t.string "header_html"
    t.string "footer_html"
    t.boolean "display_categories"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_forms_on_organization_id"
  end

  create_table "history_logs", force: :cascade do |t|
    t.string "topic"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "type"
    t.integer "state", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "tags", default: [], array: true
    t.bigint "person_id", null: false
    t.bigint "service_area_id", null: false
    t.bigint "location_id"
    t.bigint "submission_id"
    t.bigint "urgency_level_id"
    t.boolean "inexhaustible", default: false, null: false
    t.index ["location_id"], name: "index_listings_on_location_id"
    t.index ["person_id"], name: "index_listings_on_person_id"
    t.index ["service_area_id"], name: "index_listings_on_service_area_id"
    t.index ["submission_id"], name: "index_listings_on_submission_id"
    t.index ["tags"], name: "index_listings_on_tags", using: :gin
    t.index ["urgency_level_id"], name: "index_listings_on_urgency_level_id"
  end

  create_table "location_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "display_to_public", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["display_to_public"], name: "index_location_types_on_display_to_public"
  end

  create_table "locations", force: :cascade do |t|
    t.string "street_address"
    t.string "city"
    t.string "state", limit: 2
    t.string "zip", limit: 5
    t.string "county"
    t.string "region"
    t.string "neighborhood"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_type_id", null: false
    t.index ["location_type_id"], name: "index_locations_on_location_type_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "provider_id"
    t.string "provider_type"
    t.string "receiver_type"
    t.integer "receiver_id"
    t.string "status"
    t.string "notes"
    t.boolean "tentative", default: true, null: false
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "exchanged_at"
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.string "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "created_by_id"
    t.boolean "is_approved", default: true, null: false
    t.index ["created_by_id"], name: "index_mobility_string_translations_on_created_by_id"
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_string_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_string_translations_on_keys", unique: true
    t.index ["translatable_type", "key", "value", "locale"], name: "index_mobility_string_translations_on_query_keys"
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.text "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "created_by_id"
    t.boolean "is_approved", default: true, null: false
    t.index ["created_by_id"], name: "index_mobility_text_translations_on_created_by_id"
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_text_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_text_translations_on_keys", unique: true
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "description"
    t.string "facebook_url"
    t.string "website_url"
    t.string "phone"
    t.boolean "is_instance_owner", default: true, null: false
    t.boolean "has_sms_account", default: false, null: false
    t.boolean "has_hosting_account", default: false, null: false
    t.boolean "has_mailer_account", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.bigint "service_area_id"
    t.boolean "display_on_org_chart", default: true, null: false
    t.string "logo_url"
    t.string "favicon_url"
    t.index ["location_id"], name: "index_organizations_on_location_id"
    t.index ["service_area_id"], name: "index_organizations_on_service_area_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "phone_2"
    t.string "email_2"
    t.string "preferred_contact_timeframe"
    t.text "skills"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id"
    t.bigint "service_area_id"
    t.bigint "user_id"
    t.string "preferred_locale", default: "en", null: false
    t.integer "monthly_matches_max", default: 0
    t.float "monthly_donation_amount_max", default: 0.0
    t.integer "preferred_contact_method_id"
    t.index ["location_id"], name: "index_people_on_location_id"
    t.index ["service_area_id"], name: "index_people_on_service_area_id"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "organization_id"
    t.string "position_type"
    t.string "name"
    t.string "description"
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_primary", default: false, null: false
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "team_id"
    t.boolean "display_on_org_chart", default: true, null: false
    t.index ["organization_id"], name: "index_positions_on_organization_id"
    t.index ["person_id"], name: "index_positions_on_person_id"
    t.index ["team_id"], name: "index_positions_on_team_id"
  end

  create_table "service_areas", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "organization_id"
    t.string "service_area_type"
    t.string "name"
    t.string "description"
    t.boolean "display_to_public", default: true, null: false
    t.integer "display_order", default: 10, null: false
    t.boolean "is_created_by_admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "location_id", null: false
    t.index ["display_order"], name: "index_service_areas_on_display_order"
    t.index ["display_to_public"], name: "index_service_areas_on_display_to_public"
    t.index ["is_created_by_admin"], name: "index_service_areas_on_is_created_by_admin"
    t.index ["location_id"], name: "index_service_areas_on_location_id"
    t.index ["name"], name: "index_service_areas_on_name"
    t.index ["organization_id"], name: "index_service_areas_on_organization_id"
    t.index ["parent_id"], name: "index_service_areas_on_parent_id"
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

  create_table "shift_matches", force: :cascade do |t|
    t.bigint "shift_id", null: false
    t.bigint "match_id", null: false
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_shift_matches_on_match_id"
    t.index ["shift_id"], name: "index_shift_matches_on_shift_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "team_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_shifts_on_person_id"
    t.index ["team_id"], name: "index_shifts_on_team_id"
  end

  create_table "software_feedbacks", force: :cascade do |t|
    t.bigint "created_by_id"
    t.string "feedback_type"
    t.string "module_name"
    t.string "page_url"
    t.string "name", null: false
    t.string "urgency"
    t.integer "urgency_order"
    t.string "notes"
    t.boolean "completed", default: false, null: false
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["completed"], name: "index_software_feedbacks_on_completed"
    t.index ["created_by_id"], name: "index_software_feedbacks_on_created_by_id"
  end

  create_table "submission_responses", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "custom_form_question_id", null: false
    t.boolean "boolean_response"
    t.date "date_response"
    t.datetime "datetime_response"
    t.integer "integer_response"
    t.text "text_response"
    t.string "string_response"
    t.text "array_response", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["custom_form_question_id"], name: "index_submission_responses_on_custom_form_question_id"
    t.index ["string_response"], name: "index_submission_responses_on_string_response"
    t.index ["submission_id"], name: "index_submission_responses_on_submission_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "service_area_id", null: false
    t.string "form_name"
    t.string "privacy_level_requested"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_submissions_on_person_id"
    t.index ["service_area_id"], name: "index_submissions_on_service_area_id"
  end

  create_table "system_locales", force: :cascade do |t|
    t.string "locale", null: false
    t.string "locale_name", null: false
    t.boolean "publish_in_dropdowns", default: true, null: false
    t.boolean "publish_translations", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["locale"], name: "index_system_locales_on_locale"
    t.index ["publish_in_dropdowns"], name: "index_system_locales_on_publish_in_dropdowns"
    t.index ["publish_translations"], name: "index_system_locales_on_publish_translations"
  end

  create_table "system_settings", force: :cascade do |t|
    t.string "exchange_type", default: "peer_to_peer", null: false
    t.boolean "separate_asks_offers", default: true, null: false
    t.boolean "community_resources_module", default: true, null: false
    t.boolean "announcements_module", default: true, null: false
    t.boolean "donations_module", default: true, null: false
    t.boolean "positions_module", default: true, null: false
    t.boolean "shared_accounts_module", default: true, null: false
    t.boolean "allow_sms", default: false, null: false
    t.boolean "chat_module", default: true, null: false
    t.text "landing_page_text_what"
    t.text "landing_page_text_who"
    t.text "landing_page_text_how"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "about_us_text"
    t.string "confirmation_page_text_header"
    t.string "confirmation_page_text_body"
    t.string "confirmation_page_text_link_header"
    t.string "confirmation_page_text_footer"
    t.boolean "display_navbar", default: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "standing_meeting_schedule"
    t.boolean "display_on_org_chart", default: true, null: false
    t.index ["organization_id"], name: "index_teams_on_organization_id"
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
    t.string "role", default: "unset"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "communication_logs", "matches"
  add_foreign_key "communication_logs", "people"
  add_foreign_key "community_resources", "locations"
  add_foreign_key "community_resources", "organizations"
  add_foreign_key "community_resources", "service_areas"
  add_foreign_key "donations", "people"
  add_foreign_key "feedbacks", "matches"
  add_foreign_key "form_questions", "custom_form_questions"
  add_foreign_key "form_questions", "forms"
  add_foreign_key "forms", "organizations"
  add_foreign_key "listings", "locations"
  add_foreign_key "listings", "people"
  add_foreign_key "listings", "service_areas"
  add_foreign_key "listings", "submissions"
  add_foreign_key "locations", "location_types"
  add_foreign_key "organizations", "locations"
  add_foreign_key "organizations", "service_areas"
  add_foreign_key "people", "locations"
  add_foreign_key "people", "service_areas"
  add_foreign_key "people", "users"
  add_foreign_key "positions", "organizations"
  add_foreign_key "positions", "people"
  add_foreign_key "positions", "teams"
  add_foreign_key "service_areas", "locations"
  add_foreign_key "service_areas", "organizations"
  add_foreign_key "shift_matches", "matches"
  add_foreign_key "shift_matches", "shifts"
  add_foreign_key "shifts", "people"
  add_foreign_key "shifts", "teams"
  add_foreign_key "submission_responses", "custom_form_questions"
  add_foreign_key "submission_responses", "submissions"
  add_foreign_key "submissions", "people"
  add_foreign_key "submissions", "service_areas"
  add_foreign_key "taggings", "tags"
  add_foreign_key "teams", "organizations"
end
