require 'rails_helper'

RSpec.describe "external_resources/show", type: :view do
  before(:each) do
    @external_resource = assign(:external_resource, ExternalResource.create!(
      name: "Name",
      website_url: "Website Url",
      facebook_url: "Facebook Url",
      phone: "Phone",
      description: "Description",
      display_on_website_start: Date.today,
      display_on_website_end: Date.today,
      youtube_identifier: "Youtube Identifier",
      location: nil,
      reviewed: true
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Website Url/)
    expect(rendered).to match(/Facebook Url/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Youtube Identifier/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Reviewed/)
  end
end
