class FormQuestion < ApplicationRecord
  belongs_to :form
  belongs_to :custom_form_question
end

# == Schema Information
#
# Table name: form_questions
#
#  id                      :bigint           not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  custom_form_question_id :bigint           not null
#  form_id                 :bigint           not null
#
# Indexes
#
#  index_form_questions_on_custom_form_question_id  (custom_form_question_id)
#  index_form_questions_on_form_id                  (form_id)
#
# Foreign Keys
#
#  fk_rails_...  (custom_form_question_id => custom_form_questions.id)
#  fk_rails_...  (form_id => forms.id)
#
