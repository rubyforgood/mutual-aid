require 'rails_helper'

RSpec.describe "listings/show", type: :view do
  before(:each) do
    @listing = assign(:listing, create(:listing))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Randomly Generated Listing/)
    expect(rendered).to match(/Description/)
  end
end
