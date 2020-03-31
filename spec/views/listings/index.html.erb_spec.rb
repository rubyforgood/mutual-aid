require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  before(:each) do
    assign(:listings, create_list(:listing, 2))
  end

  it "renders a list of listings" do
    render
    assert_select "tbody>tr", count: 2
  end
end
