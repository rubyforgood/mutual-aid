class PersonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case
      when can_admin?
        original_scope.all
      when acting_user.present?
        original_scope.where(user_id: acting_user.id)
      else
        original_scope.none
      end
    end
  end

  def read?
    person_attached_to_acting_user? || can_admin?
  end

  def change?
    person_attached_to_acting_user? || can_admin?
  end

  def add?
    person_attached_to_acting_user? || sys_admin?
  end

  def delete?
    sys_admin?
  end

  private
  def person
    record
  end

  def person_attached_to_acting_user?
    person.user_id == acting_user&.id
  end
end
