class GlossaryPolicy < ApplicationPolicy
  def read?;   true        end
  def change?; can_admin?  end
end
