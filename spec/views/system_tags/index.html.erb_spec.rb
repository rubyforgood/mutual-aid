require 'rails_helper'

RSpec.describe "system_tags/index", type: :view do
  let(:organization) { create(:organization) }

  before(:each) do
    @view_action_name = "index"
    assign(:system_tags, [
      create(:system_tag,
        name: "Name",
        description: "Description",
        display_to_public: false,
        display_order: 2,
        parent: nil,
        organization: organization,
        created_by: "Created By"
      ),
      create(:system_tag,
        name: "Name2",
        description: "Description",
        display_to_public: false,
        display_order: 2,
        parent: nil,
        organization: organization,
        created_by: "Created By"
      )
    ])
  end

  it "renders a list of system_tags" do
    render
    assert_select "tr>td", text: /Name.*/, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "2", count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: organization.name, count: 2
    assert_select "tr>td", text: "Created By".to_s, count: 2
  end
end
