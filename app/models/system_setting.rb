class SystemSetting < ApplicationRecord

  EXCHANGE_TYPES = [
      "fully_moderated", # no public access
      "dispatch_moderated",  # peer-to-peer, but
      "moderation_on_request", # option on Forms to request hidden from public and/or messaging moderation
      "dispatch_assisted",  # peer-to-peer, but admins (dispatch/connectors/coordinators) can also complete matches
      "peer_to_peer" # everything is public
  ]

  # everything is public, including contact info
  # everything is public, but messaging is deidentified
  # things are optionally public, but request to connect is moderated by dispatch
  # things are optionally public, and deidentified messaging is an option
  #
  ### contribution display settings
  # all contributions are public
  # contributions are optionally public
  # no contributions are public
  # all contributions are visible to people with accounts
  # some contributions are visible to people with accounts
  #
  ### messaging settings
  # people are able to find each other's contact info
  # people are able to message each other (deidentified, a la craigslist)
  # people are able to message each other, but can request messages be tracked/moderated
  # people are not able to contact each other, but can request to be connected with specific contributions
  # people only contact dispatch
  #

  def self.current_settings
    self.last
  end


  def dispatch_assisted?
    exchange_type == "dispatch_assisted"
  end

  def dispatch_moderated?
    exchange_type == "dispatch_moderated"
  end

  def fully_moderated?
    exchange_type == "fully_moderated"
  end

  def moderation_on_request?
    exchange_type == "moderation_on_request"
  end

  def peer_to_peer?
    exchange_type == "peer_to_peer"
  end

end

# == Schema Information
#
# Table name: system_settings
#
#  id                                 :bigint           not null, primary key
#  about_us_text                      :text
#  allow_sms                          :boolean          default(FALSE), not null
#  announcements_module               :boolean          default(TRUE), not null
#  chat_module                        :boolean          default(TRUE), not null
#  community_resources_module         :boolean          default(TRUE), not null
#  confirmation_page_text_body        :string
#  confirmation_page_text_footer      :string
#  confirmation_page_text_header      :string
#  confirmation_page_text_link_header :string
#  donations_module                   :boolean          default(TRUE), not null
#  exchange_type                      :string           default("peer_to_peer"), not null
#  landing_page_text_how              :text
#  landing_page_text_what             :text
#  landing_page_text_who              :text
#  positions_module                   :boolean          default(TRUE), not null
#  separate_asks_offers               :boolean          default(TRUE), not null
#  shared_accounts_module             :boolean          default(TRUE), not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
