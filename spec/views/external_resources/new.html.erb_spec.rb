require 'rails_helper'

RSpec.describe "external_resources/new", type: :view do
  before(:each) do
    assign(:external_resource, ExternalResource.new(
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        display_on_website_start: Date.today,
        display_on_website_end: Date.today,
        youtube_identifier: "Youtube Identifier",
        location: nil,
        reviewed: false
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
      # assert_select "select[id=?]", "external_resource[display_on_website_start_1i"
      # assert_select "select[id=?]", "external_resource[display_on_website_start_2i"
      # assert_select "select[id=?]", "external_resource[display_on_website_start_3i"
      #
      # assert_select "select[id=?]", "external_resource[display_on_website_end_1i"
      # assert_select "select[id=?]", "external_resource[display_on_website_end_2i"
      # assert_select "select[id=?]", "external_resource[display_on_website_end_3i"

      assert_select "input[name=?]", "external_resource[youtube_identifier]"

      assert_select "select[name=?]", "external_resource[location_id]"

      assert_select "input[name=?]", "external_resource[reviewed]"
    end
  end
end
