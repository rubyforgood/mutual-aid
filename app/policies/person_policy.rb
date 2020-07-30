class PersonPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def edit?
    update?
  end

  def update?
    user&.person == record || user.sys_admin_role? || user.admin_role?
  end

  def create?
    (user.id == record&.user_id) || user.sys_admin_role? # && user.person.nil?
  end

  def destroy?
    user.sys_admin_role?
  end
end
