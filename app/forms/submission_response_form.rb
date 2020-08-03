class SubmissionResponseForm < BaseForm
  record :submission

  with_options default: nil do
    integer  :id
    integer  :custom_form_question_id
    string   :string_response
    boolean  :boolean_response
    date     :date_response
    # datetime :datetime_response
    integer  :integer_response
    string   :text_response
    array    :array_response, default: []
  end

  def execute
    response = submission.submission_responses.find { |response|
      response.custom_form_question_id == custom_form_question_id
    } || SubmissionResponse.new

    response.attributes = given_inputs
    response
  end
end
