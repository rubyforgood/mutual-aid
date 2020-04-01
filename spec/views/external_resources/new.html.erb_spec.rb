require 'rails_helper'

RSpec.describe "external_resources/new", type: :view do
  before(:each) do
    assign(:external_resource, ExternalResource.new(
      name: "MyString",
      website_url: "MyString",
      facebook_url: "MyString",
      phone: "MyString",
      description: "MyString",
      display_on_website: false,
      youtube_identifier: "MyString",
      location: nil
    ))
  end

  it "renders new external_resource form" do
    render

    assert_select "form[action=?][method=?]", external_resources_path, "post" do

      assert_select "input[name=?]", "external_resource[name]"

      assert_select "input[name=?]", "external_resource[website_url]"

      assert_select "input[name=?]", "external_resource[facebook_url]"

      assert_select "input[name=?]", "external_resource[phone]"

      assert_select "input[name=?]", "external_resource[description]"

      assert_select "input[name=?]", "external_resource[display_on_website]"

      assert_select "input[name=?]", "external_resource[youtube_identifier]"

      assert_select "input[name=?]", "external_resource[location_id]"
    end
  end
end
