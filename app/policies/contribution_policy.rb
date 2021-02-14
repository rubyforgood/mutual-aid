class ContributionPolicy < ApplicationPolicy
  def read?;         true       end
  def change?;       can_admin? end
  def delete?;       can_admin? end
  def read_details?; change?    end
end
