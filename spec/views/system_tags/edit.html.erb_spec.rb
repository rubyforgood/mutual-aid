require 'rails_helper'

RSpec.describe "system_tags/edit", type: :view do
  before(:each) do
    @view_action_name = "edit"
    @system_tag = assign(:system_tag, SystemTag.create!(
      name: "MyString",
      description: "MyString",
      display_to_public: false,
      display_order: 1,
      parent: nil,
      created_by: "MyString"
    ))
  end

  it "renders the edit tag form" do
    render

    assert_select "form[action=?][method=?]", system_tag_path(@system_tag), "post" do

      assert_select "input[name=?]", "system_tag[name]"

      assert_select "input[name=?]", "system_tag[description]"

      assert_select "input[name=?]", "system_tag[display_to_public]"

      assert_select "input[name=?]", "system_tag[display_order]"

      assert_select "select[name=?]", "system_tag[parent_id]"

      assert_select "input[name=?]", "system_tag[created_by]"
    end
  end
end
