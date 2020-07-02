require 'rails_helper'

RSpec.describe "expense_types/edit", type: :view do
  before(:each) do
    @expense_type = assign(:expense_type, ExpenseType.create!(
      name: "MyString",
      description: "MyString"
    ))
  end

  it "renders the edit expense_type form" do
    render

    assert_select "form[action=?][method=?]", expense_type_path(@expense_type), "post" do

      assert_select "input[name=?]", "expense_type[name]"

      assert_select "input[name=?]", "expense_type[description]"
    end
  end
end
