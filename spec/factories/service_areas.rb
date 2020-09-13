FactoryBot.define do
  factory :service_area do
    association :location
    association :organization
    service_area_type { Faker::Name.name }
    parent { nil }
    name { Faker::Name.name }
  end
end

# == Schema Information
#
# Table name: service_areas
#
#  id                  :bigint           not null, primary key
#  description         :string
#  display_order       :integer          default(10), not null
#  display_to_public   :boolean          default(TRUE), not null
#  is_created_by_admin :boolean          default(FALSE), not null
#  name                :string
#  service_area_type   :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  location_id         :bigint           not null
#  organization_id     :bigint
#  parent_id           :bigint
#
# Indexes
#
#  index_service_areas_on_display_order        (display_order)
#  index_service_areas_on_display_to_public    (display_to_public)
#  index_service_areas_on_is_created_by_admin  (is_created_by_admin)
#  index_service_areas_on_location_id          (location_id)
#  index_service_areas_on_name                 (name)
#  index_service_areas_on_organization_id      (organization_id)
#  index_service_areas_on_parent_id            (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (organization_id => organizations.id)
#
