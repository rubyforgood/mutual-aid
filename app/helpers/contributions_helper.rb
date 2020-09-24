module ContributionsHelper
  def peer_to_peer_preferred_contact_details
    preferred_contact_method = peer_to_peer_preferred_contact_method
    if preferred_contact_method.name == "Email"
      current_user&.person&.email
    else
      current_user&.person&.phone
    end
  end

  def peer_to_peer_preferred_contact_method
    @peer_to_peer_preferred_contact_method ||= current_user&.person&.preferred_contact_method
  end
end
