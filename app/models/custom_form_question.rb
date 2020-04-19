class CustomFormQuestion < ApplicationRecord

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

end
