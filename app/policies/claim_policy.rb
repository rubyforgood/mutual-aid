class ClaimPolicy < ApplicationPolicy
  def add?
    user.present? && system_settings.peer_to_peer?
  end
end
