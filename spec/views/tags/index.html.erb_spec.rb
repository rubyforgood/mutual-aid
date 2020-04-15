require 'rails_helper'

RSpec.describe "tags/index", type: :view do
  before(:each) do
    assign(:tags, [
      Tag.create!(
        name: "Name",
        description: "Description",
        display_to_public: false,
        display_order: 2,
        parent: nil,
        created_by: "Created By"
      ),
      Tag.create!(
        name: "Name",
        description: "Description",
        display_to_public: false,
        display_order: 2,
        parent: nil,
        created_by: "Created By"
      )
    ])
  end

  it "renders a list of tags" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Created By".to_s, count: 2
  end
end
