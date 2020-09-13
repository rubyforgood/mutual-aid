FactoryBot.define do
  factory :community_resource do
    name { "MyString" }
  end
end

# == Schema Information
#
# Table name: community_resources
#
#  id                  :bigint           not null, primary key
#  description         :string
#  facebook_url        :string
#  is_approved         :boolean          default(TRUE), not null
#  is_created_by_admin :boolean          default(TRUE), not null
#  name                :string
#  phone               :string
#  publish_from        :date
#  publish_until       :date
#  tags                :string           default([]), is an Array
#  website_url         :string
#  youtube_identifier  :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  location_id         :bigint
#  organization_id     :bigint
#  service_area_id     :bigint
#
# Indexes
#
#  index_community_resources_on_is_approved          (is_approved)
#  index_community_resources_on_is_created_by_admin  (is_created_by_admin)
#  index_community_resources_on_location_id          (location_id)
#  index_community_resources_on_organization_id      (organization_id)
#  index_community_resources_on_service_area_id      (service_area_id)
#  index_community_resources_on_tags                 (tags) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#
