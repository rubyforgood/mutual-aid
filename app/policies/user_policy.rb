class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case
      when can_admin?
        original_scope.all
      when acting_user.present?
        original_scope.where(id: acting_user.id)
      else
        original_scope.none
      end
    end
  end

  def read?
    target_user_is_acting_user? || can_admin?
  end

  def change?
    target_user_is_acting_user? || can_admin?
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

  def target_user_is_acting_user?
    acting_user.present? && target_user == acting_user
  end
end
