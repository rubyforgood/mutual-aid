require 'rails_helper'

RSpec.describe "system_tags/new", type: :view do
  before(:each) do
    @view_action_name = "new"
    assign(:system_tag, SystemTag.new(
      name: "MyString",
      description: "MyString",
      display_to_public: false,
      display_order: 1,
      parent: nil,
      created_by: "MyString"
    ))
  end

  it "renders new tag form" do
    render

    assert_select "form[action=?][method=?]", system_tags_path, "post" do

      assert_select "input[name=?]", "system_tag[name]"

      assert_select "input[name=?]", "system_tag[description]"

      assert_select "input[name=?]", "system_tag[display_to_public]"

      assert_select "input[name=?]", "system_tag[display_order]"

      assert_select "select[name=?]", "system_tag[parent_id]"

      assert_select "input[name=?]", "system_tag[created_by]"
    end
  end
end
