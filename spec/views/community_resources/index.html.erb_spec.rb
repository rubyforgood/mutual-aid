require 'rails_helper'

RSpec.describe "community_resources/index", type: :view do
  before(:each) do
    @view_action_name = "index"
    @community_resources = [
        create(:community_resource,
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        publish_from: Date.today,
        publish_until: Date.today,
        youtube_identifier: "Youtube Identifier",
        system_location: create(:system_location),
        is_approved: false
      ),
        create(:community_resource,
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        publish_from: Date.today + 2.days,
        publish_until: Date.today + 7.days,
        youtube_identifier: "Youtube Identifier",
        system_location: create(:system_location),
        is_approved: false
      )
    ]
  end

  it "renders a list of community_resources" do
    render
    skip
    # assert_select "tr", class: "external-resource", count: 2 # TODO add valid test here
  end
end
