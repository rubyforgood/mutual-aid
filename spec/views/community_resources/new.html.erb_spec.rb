require 'rails_helper'

RSpec.describe "community_resources/new", type: :view do
  before(:each) do
    @view_action_name = "new"
    @community_resource = create(:community_resource,
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        publish_from: Date.today,
        publish_until: Date.today,
        youtube_identifier: "Youtube Identifier",
        approved: false
    )
  end

  it "renders new community_resource form" do
    render

    assert_select "#community_resource_description"
    assert_select "#community_resource_publish_from_1i"
    assert_select "#community_resource_publish_until_1i"
    assert_select "#community_resource_system_location_id"
    assert_select "#community_resource_organization_id"

    assert_select "form input" do
      assert_select "input[id=?]", "community_resource_name"
      assert_select "input[id=?]", "community_resource_website_url"
      assert_select "input[id=?]", "community_resource_facebook_url"
      assert_select "input[id=?]", "community_resource_phone"
      assert_select "input[id=?]", "community_resource_youtube_identifier"
      assert_select "input[id=?]", "community_resource_approved"
    end
  end
end
