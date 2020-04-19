require 'rails_helper'

RSpec.describe "external_resources/index", type: :view do
  before(:each) do
    @view_action_name = "index"
    @external_resources = [
        create(:external_resource,
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        publish_from: Date.today,
        publish_until: Date.today,
        youtube_identifier: "Youtube Identifier",
        system_location: create(:system_location),
        approved: false
      ),
        create(:external_resource,
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        publish_from: Date.today + 2.days,
        publish_until: Date.today + 7.days,
        youtube_identifier: "Youtube Identifier",
        system_location: create(:system_location),
        approved: false
      )
    ]
  end

  it "renders a list of external_resources" do
    render
    skip
    # assert_select "tr", class: "external-resource", count: 2 # TODO add valid test here
  end
end
