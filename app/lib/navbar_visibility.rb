module NavbarVisibility
  NAVBAR_HIDEABLE = {
    'announcements' => ['new', 'create'],
    'asks' => ['new', 'create'],
    'community_ressources' => ['new', 'show'],
    'offers' => ['new', 'create'],
    'public_pages' => ['about', 'contributions', 'landing_page', 'version'],
    'thank_you' => ['show']
  }

  def self.shown?(controller, action, display_navbar)
    display_navbar || !hidden?(controller, action)
  end
  def self.hidden?(controller, action)
    NAVBAR_HIDEABLE[controller]&.include?(action)
  end 
end
