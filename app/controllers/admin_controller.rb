# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :ensure_authorized_as_admin

  private

  def ensure_authorized_as_admin
    unless current_user.admin_role? || current_user.sys_admin_role?
      fail Pundit::NotAuthorizedError, "Sorry, only admins are authorized to do that."
    end

    skip_authorization
    skip_policy_scope
  end
end
