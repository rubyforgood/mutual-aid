module NavbarHelper
  def self.show_navbar?(controller, action, settings)
    always_display = hidden_places[controller].nil? || !hidden_places[controller].include?(action)
    always_display || settings
  end

  def self.hidden_places
    hidden_places = {}
    hidden_places['announcements'] = ['new', 'create']
    hidden_places['asks'] = ['new', 'create']
    hidden_places['community_ressources'] = ['new', 'show']
    hidden_places['offers'] = ['new', 'create']
    hidden_places['public_pages'] = ['about', 'contributions', 'landing_page', 'version']
    hidden_places['thank_you'] = ['show']
    hidden_places['offers'] = ['new', 'create']
    hidden_places['offers'] = ['new', 'create']

    hidden_places
  end
end
