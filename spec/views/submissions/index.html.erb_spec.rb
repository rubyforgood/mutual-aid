require 'rails_helper'

RSpec.describe "submissions/index", type: :view do
  let(:person) { create(:person) }
  before(:each) do
    assign(:submissions, [
      create(:submission,
             person: person,
      ),
      create(:submission,
             person: person,
      )
    ])
  end

  it "renders a list of submissions" do
    render

    assert_select "tr>td", text: person&.name, count: 2
  end
end
