class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def edit?
    update?
  end

  def update?
    user == record || user.sys_admin_role? || user.admin_role?
  end

  def create?
    true
  end

  def destroy?
    user.sys_admin_role?
  end
end