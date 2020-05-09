require 'rails_helper'

RSpec.describe "contact_methods/show", type: :view do
  before(:each) do
    @contact_method = create(:contact_method,
      name: "Name",
      field: "Field",
      enabled: false
    )
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Field/)
    expect(rendered).to match(/false/)
  end
end
