class PersonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if can_admin?
        scope.all
      elsif user.present?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end

  def read?
    own_person? || can_admin?
  end

  def change?
    own_person? || can_admin?
  end

  def add?
    own_person? || sys_admin?
  end

  def delete?
    sys_admin?
  end

  private

  def person
    record
  end

  def own_person?
    person.user_id && person.user_id == user&.id
  end
end
