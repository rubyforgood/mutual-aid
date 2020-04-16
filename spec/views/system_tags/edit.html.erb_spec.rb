require 'rails_helper'

RSpec.describe "system_tags/edit", type: :view do
  before(:each) do
    @tag = assign(:tag, SystemTag.create!(
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

    assert_select "form[action=?][method=?]", tag_path(@tag), "post" do

      assert_select "input[name=?]", "tag[name]"

      assert_select "input[name=?]", "tag[description]"

      assert_select "input[name=?]", "tag[display_to_public]"

      assert_select "input[name=?]", "tag[display_order]"

      assert_select "input[name=?]", "tag[parent_id]"

      assert_select "input[name=?]", "tag[created_by]"
    end
  end
end
