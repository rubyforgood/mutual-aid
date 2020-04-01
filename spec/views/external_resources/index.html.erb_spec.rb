require 'rails_helper'

RSpec.describe "external_resources/index", type: :view do
  before(:each) do
    assign(:external_resources, [
      ExternalResource.create!(
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        display_on_website: false,
        youtube_identifier: "Youtube Identifier",
        location: nil
      ),
      ExternalResource.create!(
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        display_on_website: false,
        youtube_identifier: "Youtube Identifier",
        location: nil
      )
    ])
  end

  it "renders a list of external_resources" do
    render
    skip
    # assert_select "tr", class: "external-resource", count: 2 # TODO add valid test here
  end
end
