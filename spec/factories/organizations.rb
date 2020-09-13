FactoryBot.define do
  factory :organization do
    name { Faker::Name.name }
    trait :with_location do
      association :location
    end
  end
end

# == Schema Information
#
# Table name: organizations
#
#  id                   :bigint           not null, primary key
#  description          :string
#  display_on_org_chart :boolean          default(TRUE), not null
#  facebook_url         :string
#  favicon_url          :string
#  has_hosting_account  :boolean          default(FALSE), not null
#  has_mailer_account   :boolean          default(FALSE), not null
#  has_sms_account      :boolean          default(FALSE), not null
#  is_instance_owner    :boolean          default(TRUE), not null
#  logo_url             :string
#  name                 :string
#  phone                :string
#  short_name           :string
#  website_url          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  location_id          :bigint
#  service_area_id      :bigint
#
# Indexes
#
#  index_organizations_on_location_id      (location_id)
#  index_organizations_on_service_area_id  (service_area_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#
