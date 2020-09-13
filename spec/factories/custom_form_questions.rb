FactoryBot.define do
  factory :custom_form_question do
    name { "My custom question" }
  end
end

# == Schema Information
#
# Table name: custom_form_questions
#
#  id            :bigint           not null, primary key
#  display_order :string
#  form_hook     :string
#  form_type     :string
#  hint_text     :string
#  input_type    :string
#  is_required   :boolean          default(TRUE), not null
#  name          :string
#  option_list   :text             default([]), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
