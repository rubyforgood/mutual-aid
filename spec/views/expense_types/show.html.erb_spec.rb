require 'rails_helper'

RSpec.describe "expense_types/show", type: :view do
  before(:each) do
    @expense_type = assign(:expense_type, ExpenseType.create!(
      name: "Name",
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
