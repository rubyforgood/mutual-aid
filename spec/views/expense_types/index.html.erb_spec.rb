require 'rails_helper'

RSpec.describe "expense_types/index", type: :view do
  before(:each) do
    assign(:expense_types, [
      ExpenseType.create!(
        name: "Name",
        description: "Description"
      ),
      ExpenseType.create!(
        name: "Name",
        description: "Description"
      )
    ])
  end

  it "renders a list of expense_types" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
  end
end
