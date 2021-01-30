class ClaimPolicy < ApplicationPolicy
  def add?
    acting_user.present? && system_settings.peer_to_peer?
  end
end
