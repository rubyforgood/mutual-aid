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
