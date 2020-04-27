require 'rails_helper'

RSpec.describe "community_resources/show", type: :view do
  before(:each) do
    @view_action_name = "show"
    @community_resource = assign(:community_resource, CommunityResource.create!(
      name: "Name",
      website_url: "Website Url",
      facebook_url: "Facebook Url",
      phone: "Phone",
      description: "Description",
      publish_from: Date.today,
      publish_until: Date.today,
      youtube_identifier: "Youtube Identifier",
      system_location: create(:system_location),
      is_approved: true
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Website Url/)
    expect(rendered).to match(/Facebook Url/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Youtube Identifier/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Approved/)
  end
end
