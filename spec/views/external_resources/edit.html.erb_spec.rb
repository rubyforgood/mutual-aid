require 'rails_helper'

RSpec.describe "external_resources/edit", type: :view do
  before(:each) do
    @external_resource = assign(:external_resource, ExternalResource.create!(
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

  it "renders the edit external_resource form" do
    render

    assert_select "form[action=?][method=?]", external_resource_path(@external_resource), "post" do

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
