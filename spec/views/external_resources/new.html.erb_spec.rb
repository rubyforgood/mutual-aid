require 'rails_helper'

RSpec.describe "external_resources/new", type: :view do
  before(:each) do
    @view_action_name = "new"
    @external_resource = create(:external_resource,
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

  it "renders new external_resource form" do
    render

    assert_select "#external_resource_description"
    assert_select "#external_resource_publish_from_1i"
    assert_select "#external_resource_publish_until_1i"
    assert_select "#external_resource_system_location_id"
    assert_select "#external_resource_organization_id"

    assert_select "form input" do
      assert_select "input[id=?]", "external_resource_name"
      assert_select "input[id=?]", "external_resource_website_url"
      assert_select "input[id=?]", "external_resource_facebook_url"
      assert_select "input[id=?]", "external_resource_phone"
      assert_select "input[id=?]", "external_resource_youtube_identifier"
      assert_select "input[id=?]", "external_resource_approved"
    end
  end
end
