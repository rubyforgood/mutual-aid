require 'rails_helper'

RSpec.describe "expense_types/new", type: :view do
  before(:each) do
    assign(:expense_type, ExpenseType.new(
      name: "MyString",
      description: "MyString"
    ))
  end

  it "renders new expense_type form" do
    render

    assert_select "form[action=?][method=?]", expense_types_path, "post" do

      assert_select "input[name=?]", "expense_type[name]"

      assert_select "input[name=?]", "expense_type[description]"
    end
  end
end
