class Form < ApplicationRecord
  belongs_to :organization
  has_many :questions, class_name: 'FormQuestion'
end
