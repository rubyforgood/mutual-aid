module NavbarVisibility
  NAVBAR_HIDEABLE = {
    'announcements' => ['new', 'create'],
    'asks' => ['new', 'create'],
    'community_ressources' => ['new', 'show'],
    'offers' => ['new', 'create'],
    'public_pages' => ['about', 'contributions', 'landing_page', 'version'],
    'thank_you' => ['show']
  }

  def self.shown_navbar?(controller, action, display_navbar)
    always_display = NAVBAR_HIDEABLE[controller].nil? || !NAVBAR_HIDEABLE[controller].include?(action)
    always_display || display_navbar
  end
end
