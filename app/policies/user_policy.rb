class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case
      when can_admin?
        scope.all
      when user.present?
        scope.where(id: user.id)
      else
        scope.none
      end
    end
  end

  def permitted_attributes
    [
      :email,
      person_attributes: %i[id name email phone preferred_contact_method_id _destroy]
    ].tap do |permitted|
      permitted << :role if can_admin?
    end
  end

  def read?
    own_user? || can_admin?
  end

  def change?
    own_user? || can_admin?
  end

  def add?
    true
  end

  def delete?
    sys_admin?
  end

  private
  def target_user
    record
  end

  def own_user?
    user.present? && target_user == user
  end
end
