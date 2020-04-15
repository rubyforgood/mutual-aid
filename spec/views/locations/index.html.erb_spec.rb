require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        name: "Name",
        parent: nil,
        location_type: "Location Type",
        description: "Description",
        street_address: "Street Address",
        city: "City",
        state: "State",
        zip: "Zip",
        county: "County",
        facebook_url: "Facebook Url",
        website_url: "Website Url",
        phone: "Phone"
      ),
      Location.create!(
        name: "Name",
        parent: nil,
        location_type: "Location Type",
        description: "Description",
        street_address: "Street Address",
        city: "City",
        state: "State",
        zip: "Zip",
        county: "County",
        facebook_url: "Facebook Url",
        website_url: "Website Url",
        phone: "Phone"
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Location Type".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "Street Address".to_s, count: 2
    assert_select "tr>td", text: "City".to_s, count: 2
    assert_select "tr>td", text: "State".to_s, count: 2
    assert_select "tr>td", text: "Zip".to_s, count: 2
    assert_select "tr>td", text: "County".to_s, count: 2
    assert_select "tr>td", text: "Facebook Url".to_s, count: 2
    assert_select "tr>td", text: "Website Url".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
  end
end
