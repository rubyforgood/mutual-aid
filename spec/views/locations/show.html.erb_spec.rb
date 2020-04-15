require 'rails_helper'

RSpec.describe "locations/show", type: :view do
  before(:each) do
    @location = assign(:location, Location.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Location Type/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Street Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/County/)
    expect(rendered).to match(/Facebook Url/)
    expect(rendered).to match(/Website Url/)
    expect(rendered).to match(/Phone/)
  end
end
