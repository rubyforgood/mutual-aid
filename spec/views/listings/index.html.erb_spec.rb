require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  before(:each) do
    assign(:listings, create_list(:listing, 2))
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", text: "Randomly Generated Listing".to_s, count: 2
    assert_select "tr>td", text: "A Description".to_s, count: 2
  end
end
