Context = Struct.new(
  :admin_param,
  :system_settings,
  :user,
  keyword_init: true
) do

  def system_settings
    self[:system_settings] ||= SystemSetting.current_settings
  end

  def can_admin?
    user && (user&.admin_role? || user&.sys_admin_role?) && admin_param != 'false'
  end

  def to_h
    {
      system_settings: system_settings,
      user: user,
    }
  end
end
