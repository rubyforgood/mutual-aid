class ContributionPolicy < ApplicationPolicy
  def read?
    acting_user && (acting_user.admin_role? || acting_user.sys_admin_role? )
  end

  def change?
    acting_user && (acting_user.admin_role? || acting_user.sys_admin_role? )
  end

  def read_details?
    change?
  end
end
