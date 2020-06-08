class Form < ApplicationRecord
  belongs_to :organization
  has_many :form_questions
end
