require 'rails_helper'

RSpec.describe "submissions/show", type: :view do
  let(:person) { create(:person) }
  let(:service_area) { create(:service_area) }
  before(:each) do
    @submission = create(:submission,
                         person: person,
                         service_area: service_area,
                         form_name: "Form Name",
                         body: "MyText"
    )
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Form Name/)
    expect(rendered).to match(/MyText/)
  end
end
