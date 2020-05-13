class SubmissionResponse < ApplicationRecord
  belongs_to :submission
  belongs_to :custom_form_question
end
