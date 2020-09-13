FactoryBot.define do
  factory :submission_response do
    submission
    custom_form_question
    boolean_response { false }
    date_response { "2020-05-12" }
    datetime_response { "2020-05-12 23:13:57" }
    integer_response { 1 }
    text_response { "MyText" }
    string_response { "MyString" }
    array_response { "" }
  end
end

# == Schema Information
#
# Table name: submission_responses
#
#  id                      :bigint           not null, primary key
#  array_response          :text             default([]), is an Array
#  boolean_response        :boolean
#  date_response           :date
#  datetime_response       :datetime
#  integer_response        :integer
#  string_response         :string
#  text_response           :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  custom_form_question_id :bigint           not null
#  submission_id           :bigint           not null
#
# Indexes
#
#  index_submission_responses_on_custom_form_question_id  (custom_form_question_id)
#  index_submission_responses_on_string_response          (string_response)
#  index_submission_responses_on_submission_id            (submission_id)
#
# Foreign Keys
#
#  fk_rails_...  (custom_form_question_id => custom_form_questions.id)
#  fk_rails_...  (submission_id => submissions.id)
#
