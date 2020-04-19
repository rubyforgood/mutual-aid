require 'rails_helper'

RSpec.describe "system_tags/show", type: :view do
  before(:each) do
    @view_action_name = "show"
    @system_tag = assign(:system_tag, SystemTag.create!(
      name: "Name",
      description: "Description",
      display_to_public: false,
      display_order: 2,
      parent: nil,
      created_by: "Created By"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Created By/)
  end
end
