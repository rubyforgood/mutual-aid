class SubmissionResponseForm < BaseForm
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
    SubmissionResponse.find_or_new(id).tap do |submission_response|
      submission_response.attributes = given_inputs
    end
  end
end
