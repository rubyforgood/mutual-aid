class CommunityResourcePolicy < ApplicationPolicy
  def read?;   true       end
  def add?;    true       end
  def change?; can_admin? end
  def delete?; can_admin? end

  def permitted_attributes
    CommunityResourceForm.filter_keys.tap do |keys|
      keys.delete(:is_approved) unless can_admin?
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      can_admin? ? scope : scope.published
    end
  end
end
