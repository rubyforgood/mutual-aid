require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    @view_action_name = "index"
    assign(:locations, [
      Location.create!(
        name: "NAME",
        parent: nil,
        location_type: "Location Type",
        street_address: "Street Address",
        city: "City",
        state: "NY",
        zip: "12345",
        county: "County",
      ),
      Location.create!(
        name: "NAME",
        parent: nil,
        location_type: "Location Type",
        street_address: "Street Address",
        city: "City",
        state: "NY",
        zip: "12345",
        county: "County",
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", text: "Location Type".to_s, count: 2
    assert_select "tr>td", text: "Street Address".to_s, count: 2
    assert_select "tr>td", text: "City, NY".to_s, count: 2
    assert_select "tr>td", text: "12345".to_s, count: 2
    assert_select "tr>td", text: "County".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
