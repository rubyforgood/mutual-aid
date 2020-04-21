require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  before(:each) do
    @view_action_name = "show"
    @category = create(:category,
                       name: "Name",
                       description: "Description",
                       display_to_public: false,
                       display_order: 2,
                       parent: nil,
                       is_created_by_admin: true)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Yes/)
  end
end
