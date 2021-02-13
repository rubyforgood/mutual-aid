class AnnouncementPolicy < ApplicationPolicy
  def read?;    true       end
  def add?;     true       end
  def change?;  can_admin? end
  def destroy?; can_admin? end

  def permitted_attributes
    %i[name description publish_from publish_until].tap do |permitted|
      permitted.push :is_approved if can_admin?
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      can_admin? ? original_scope : original_scope.published
    end
  end
end
