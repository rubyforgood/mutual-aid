require 'rails_helper'

RSpec.describe "community_resources/edit", type: :view do
  before(:each) do
    @view_action_name = "edit"
    @community_resource = create(:community_resource,
      name: "MyString",
      website_url: "MyString",
      facebook_url: "MyString",
      phone: "MyString",
      description: "MyString",
      publish_from: Date.today,
      publish_until: Date.today + 30.days,
      youtube_identifier: "MyString",
      system_location: create(:system_location),
      is_approved: false
    )
  end

  it "renders the edit community_resource form" do
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
