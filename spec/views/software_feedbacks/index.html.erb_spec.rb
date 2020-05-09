require 'rails_helper'

RSpec.describe "software_feedbacks/index", type: :view do
  let(:user) { create(:user) }
  before(:each) do
    assign(:software_feedbacks, [
      create(:software_feedback,
        created_by: user,
      ),
      create(:software_feedback,
        created_by: user,
      )
    ])
  end

  it "renders a list of software_feedbacks" do
    render
    assert_select "tr>td", text: user&.name, count: 2
  end
end
