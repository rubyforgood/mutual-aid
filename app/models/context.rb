Context = Struct.new(
  :admin_param,
  :host_organization,
  :system_settings,
  :user,
  keyword_init: true
) do
  def host_organization
    self[:host_organization] ||= Organization.host_organization
  end

  def system_settings
    self[:system_settings] ||= SystemSetting.current_settings
  end

  def can_admin?
    user && (user&.admin_role? || user&.sys_admin_role?) && admin_param != 'false'
  end

  def to_h
    {
      can_admin: can_admin?,
      host_organization: host_organization,
      system_settings: system_settings,
      user: user
    }
  end
end
