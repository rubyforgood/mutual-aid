require 'rails_helper'

RSpec.describe "categories/new", type: :view do
  before(:each) do
    @view_action_name = "new"
    @category = create(:category,
      name: "Name",
      description: "Description",
      display_to_public: false,
      display_order: 2,
      parent: nil,
      is_created_by_admin: true)
  end

  it "renders new category form" do
    render

    assert_select "#category_description"
    assert_select "#category_display_to_public_true"
    assert_select "#category_display_to_public_false"
    assert_select "#category_is_created_by_admin_true"
    assert_select "#category_is_created_by_admin_false"
    assert_select "#category_parent_id"

    assert_select "form input" do
      assert_select "input[id=?]", "category_name"
      assert_select "input[id=?]", "category_display_order"
    end
  end
end
