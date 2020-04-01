require 'rails_helper'

RSpec.describe "external_resources/show", type: :view do
  before(:each) do
    @external_resource = assign(:external_resource, ExternalResource.create!(
      name: "Name",
      website_url: "Website Url",
      facebook_url: "Facebook Url",
      phone: "Phone",
      description: "Description",
      display_on_website: false,
      youtube_identifier: "Youtube Identifier",
      location: nil
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
  end
end
