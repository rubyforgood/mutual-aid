require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  before(:each) do
    @view_action_name = "edit"
    @category = create(:category,
                       name: "Name",
                       description: "Description",
                       display_to_public: false,
                       display_order: 2,
                       parent: nil,
                       is_created_by_admin: true)
  end

  it "renders the edit category form" do
    render

    assert_select "form[action=?][method=?]", category_path(@category), "post" do

      assert_select "input[name=?]", "category[name]"

      assert_select "select[name=?]", "category[parent_id]"

      assert_select "textarea[name=?]", "category[description]"

      assert_select "input[name=?]", "category[display_to_public]"

      assert_select "input[name=?]", "category[display_order]"

      assert_select "input[name=?]", "category[is_created_by_admin]"
    end
  end
end
