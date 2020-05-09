require 'rails_helper'

RSpec.describe "contact_methods/new", type: :view do
  before(:each) do
    @contact_method = create(:contact_method,
      name: "MyString",
      field: "MyString",
      enabled: false
    )
  end

  it "renders new contact_method form" do
    render

    # assert_select "form[action=?][method=?]", contact_methods_path, "post" do

      assert_select "input[name=?]", "contact_method[name]"

      assert_select "select[name=?]", "contact_method[field]"

      assert_select "input[name=?]", "contact_method[enabled]"
    # end
  end
end
