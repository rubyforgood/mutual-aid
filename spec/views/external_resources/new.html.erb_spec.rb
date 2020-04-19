require 'rails_helper'

RSpec.describe "external_resources/new", type: :view do
  before(:each) do
    assign(:external_resource, ExternalResource.new(
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        publish_from: Date.today,
        publish_until: Date.today,
        youtube_identifier: "Youtube Identifier",
        location: nil,
        approved: false
    ))
  end

  it "renders new external_resource form" do
    render
    assert_select "form[action=?][method=?]", external_resources_path, "post" do

      assert_select "input[name=?]", "external_resource[name]"

      assert_select "input[name=?]", "external_resource[website_url]"

      assert_select "input[name=?]", "external_resource[facebook_url]"

      assert_select "input[name=?]", "external_resource[phone]"

      assert_select "textarea[name=?]", "external_resource[description]"

      # binding.pry # TODO - helppppppppp
      # assert_select "select[id=?]", "external_resource[publish_from_1i"
      # assert_select "select[id=?]", "external_resource[publish_from_2i"
      # assert_select "select[id=?]", "external_resource[publish_from_3i"
      #
      # assert_select "select[id=?]", "external_resource[publish_until_1i"
      # assert_select "select[id=?]", "external_resource[publish_until_2i"
      # assert_select "select[id=?]", "external_resource[publish_until_3i"

      assert_select "input[name=?]", "external_resource[youtube_identifier]"

      assert_select "select[name=?]", "external_resource[location_id]"

      assert_select "input[name=?]", "external_resource[approved]"
    end
  end
end
