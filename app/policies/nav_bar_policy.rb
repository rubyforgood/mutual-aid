class NavBarPolicy < ApplicationPolicy
  def visible_buttons
    visible = Set.new
    visible << (user ? 'Logout' : 'Login')
    visible << 'Sign Up' unless user
    visible << 'Feedback' if is_admin?(user)
    visible.merge %w[Glossary Contributions] if system_settings.peer_to_peer?
    visible.merge %w[Contributions Matches Admin] if can_admin?
    visible.to_a
  end

  private

  def is_admin?(user)
    user && (user.admin_role? || user.sys_admin_role?)
  end
end
