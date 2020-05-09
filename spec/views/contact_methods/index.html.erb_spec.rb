require 'rails_helper'

RSpec.describe "contact_methods/index", type: :view do
  before(:each) do
    assign(:contact_methods, [
        create(:contact_method,
        name: "Name",
        field: "Field",
        enabled: false
      ),
        create(:contact_method,
        name: "Name",
        field: "Field",
        enabled: false
      )
    ])
  end

  it "renders a list of contact_methods" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Field".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
