class CommunityResourcePolicy < ApplicationPolicy
  def read?;   true       end
  def add?;    true       end
  def change?; can_admin? end
  def delete?; can_admin? end

  def permitted_attributes
    [
      :description,
      :facebook_url,
      :name,
      :phone,
      :publish_from,
      :publish_until,
      :service_area_id,
      :website_url,
      :youtube_identifier,
      tag_list: [],
      organization_attributes: %i[id name _destroy],
    ]
      .tap do |permitted|
        permitted.push :is_approved if can_admin?
      end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      can_admin? ? original_scope : original_scope.published
    end
  end
end
