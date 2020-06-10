class FormQuestion < ApplicationRecord
  belongs_to :form
  belongs_to :custom_form_question
end
