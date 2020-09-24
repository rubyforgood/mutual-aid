FactoryBot.define do
  factory :system_setting do
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
