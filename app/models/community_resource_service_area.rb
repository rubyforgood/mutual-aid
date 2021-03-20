class CommunityResourceServiceArea < ApplicationRecord
  belongs_to :community_resource
  belongs_to :service_area
end

# == Schema Information
#
# Table name: community_resource_service_areas
#
#  id                    :bigint           not null, primary key
#  community_resource_id :bigint           not null
#  service_area_id       :bigint           not null
#
# Indexes
#
#  index_community_resource_service_areas_on_community_resource_id  (community_resource_id)
#  index_community_resource_service_areas_on_service_area_id        (service_area_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_resource_id => community_resources.id)
#  fk_rails_...  (service_area_id => service_areas.id)
#
