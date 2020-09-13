FactoryBot.define do
  factory :submission do
    association :person
    association :service_area
    form_name { "ask_form" }
    body { "Hash of form params" }
  end
end

# == Schema Information
#
# Table name: submissions
#
#  id                      :bigint           not null, primary key
#  body                    :text
#  form_name               :string
#  privacy_level_requested :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  person_id               :bigint           not null
#  service_area_id         :bigint           not null
#
# Indexes
#
#  index_submissions_on_person_id        (person_id)
#  index_submissions_on_service_area_id  (service_area_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#
