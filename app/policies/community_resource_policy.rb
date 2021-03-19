class CommunityResourcePolicy < ApplicationPolicy
  def read?;   true       end
  def add?;    true       end
  def change?; can_admin? end
  def delete?; can_admin? end

  def permitted_attributes
    [
      :description,
      :facebook_url,
      :location_id,
      :name,
      :phone,
      :publish_from,
      :publish_until,
      :website_url,
      :youtube_identifier,
      service_area_ids: [],
      tag_list: [],
      organization_attributes: %i[id name _destroy]
    ]
      .tap do |permitted|
        permitted.push :is_approved if can_admin?
      end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      can_admin? ? scope : scope.published
    end
  end
end
