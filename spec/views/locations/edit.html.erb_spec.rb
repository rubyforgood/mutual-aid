require 'rails_helper'

RSpec.describe "locations/edit", type: :view do
  before(:each) do
    @location = assign(:location, Location.create!(
      name: "MyString",
      parent: nil,
      location_type: "MyString",
      description: "MyString",
      street_address: "MyString",
      city: "MyString",
      state: "MyString",
      zip: "MyString",
      county: "MyString",
      facebook_url: "MyString",
      website_url: "MyString",
      phone: "MyString"
    ))
  end

  it "renders the edit location form" do
    render

    assert_select "form[action=?][method=?]", location_path(@location), "post" do

      assert_select "input[name=?]", "location[name]"

      assert_select "input[name=?]", "location[parent_id]"

      assert_select "input[name=?]", "location[location_type]"

      assert_select "input[name=?]", "location[description]"

      assert_select "input[name=?]", "location[street_address]"

      assert_select "input[name=?]", "location[city]"

      assert_select "input[name=?]", "location[state]"

      assert_select "input[name=?]", "location[zip]"

      assert_select "input[name=?]", "location[county]"

      assert_select "input[name=?]", "location[facebook_url]"

      assert_select "input[name=?]", "location[website_url]"

      assert_select "input[name=?]", "location[phone]"
    end
  end
end
