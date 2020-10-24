# frozen_string_literal: true

class UserRole
  ROLES = %w(unset neighbor volunteer dispatcher admin sys_admin).freeze

  def self.roles_as_hash
    ROLES.map { |r| [r.to_sym, r] }.to_h
  end

  def initialize(role)
    @role = role
  end
end
