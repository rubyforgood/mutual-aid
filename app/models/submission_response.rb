class SubmissionResponse < ApplicationRecord
  belongs_to :submission
  belongs_to :custom_form_question

  def name
    # self.public_send(Question::INPUT_TYPES_AND_STORAGE[question.input_type])
    name = nil
    [string_response, text_response, YAML.load(boolean_response.to_s), integer_response.to_s,
     array_response.join(", "), date_response&.strftime("%Y-%m-%d"), datetime_response&.strftime("%Y-%m-%d @ %l:%m")].each do |string|
      if string.present?
        name = string
      end
    end
    name
  end

  # def input_type
  #   question.input_type
  # end
  #
  # def question_name
  #   question.name
  # end
  #
  # def cleaned_array_response
  #   no_empty_strings = array_response - [""]
  #   no_leading_spaces = no_empty_strings.each.map{|r| r.gsub(/^\s*/,"")}
  # end
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
