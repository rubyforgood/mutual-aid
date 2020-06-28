class CustomFormQuestion < ApplicationRecord
  extend Mobility
  translates :name, type: :string
#   translates :option_list, type: :string # if this is json, ok to say string here?
  translates :hint_text, type: :string

  has_many :submission_responses
  has_many :form_questions
  has_many :mobility_string_translations, inverse_of: :translatable, class_name: "MobilityStringTranslation", foreign_key: :translatable_id

  INPUT_TYPES_AND_STORAGE = {
      "date" => "date_response",
      "datetime" => "datetime_response",
      "info_text" => nil,
      "integer" => "integer_response",

      "multiselect-checkboxes" => "array_response",
      "multiselect-dropdown" => "array_response",
      "radio" => "boolean_response",

      "file" => "string_response",
      "select" => "string_response",
      "string" => "string_response",
      "textarea" => "string_response", # for some reason textarea are being stored as string_response
      "youtube_video_id" => "string_response",
  }

  scope :translated_name, ->(name) { joins(:mobility_string_translations).
      where("mobility_string_translations.key = 'name' AND mobility_string_translations.locale = 'en'").
      where("LOWER(mobility_string_translations.value) = ?", name) }

  scope :translated_name_stem, ->(stem) { joins(:mobility_string_translations).
      where("mobility_string_translations.key = 'name' AND mobility_string_translations.locale = 'en'").
      where("mobility_string_translations.value ILIKE ?", "%#{stem}%") }
end
