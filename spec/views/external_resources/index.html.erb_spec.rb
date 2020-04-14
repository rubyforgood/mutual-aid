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
        display_on_website_start: Date.today,
        display_on_website_end: Date.today,
        youtube_identifier: "Youtube Identifier",
        location: nil,
        reviewed: false
      ),
      ExternalResource.create!(
        name: "Name",
        website_url: "Website Url",
        facebook_url: "Facebook Url",
        phone: "Phone",
        description: "Description",
        display_on_website_start: Date.today + 2.days,
        display_on_website_end: Date.today + 7.days,
        youtube_identifier: "Youtube Identifier",
        location: nil,
        reviewed: false
      )
    ])
  end

  it "renders a list of external_resources" do
    render
    skip
    # assert_select "tr", class: "external-resource", count: 2 # TODO add valid test here
  end
end
