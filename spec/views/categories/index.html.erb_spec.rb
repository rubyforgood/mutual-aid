require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  let(:organization) { create(:organization) }

  before(:each) do
    @view_action_name = "index"
    @parent_category = create(:category, name: "Parent category")
    @categories = [
      create(:category,
             name: "Category Name 1",
             description: "Description",
             display_to_public: false,
             display_order: 2,
             parent: @parent_category,
             is_created_by_admin: true),
      create(:category,
             name: "Category Name 2",
             description: "Description",
             display_to_public: false,
             display_order: 2,
             parent: @parent_category,
             is_created_by_admin: true)
    ]
  end

  it "renders a list of categories" do
    render
    # assert_select "tr>td", text: /Category Name.*/, count: 2
    # assert_select "tr>td", text: /Description.*/, count: 2
    assert_select "tr>td", text: @parent_category.name, count: 2
    # assert_select "tr>td>span", class: "fa fa-check-circle", count: 2
    # assert_select "tr>td>span", class: "fa fa-ban", count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
