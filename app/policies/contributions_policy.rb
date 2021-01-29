class ContributionsPolicy < ApplicationPolicy
  def read?
    acting_user && (acting_user.admin_role? || acting_user.sys_admin_role? )
  end
end
