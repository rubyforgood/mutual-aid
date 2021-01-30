class GlossaryPolicy < ApplicationPolicy
  def read?
    true
  end 

  def change?
    acting_user && (acting_user.admin_role? || acting_user.sys_admin_role? )
  end
end