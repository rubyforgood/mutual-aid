require 'rails_helper'

RSpec.describe "shift_matches/index", type: :view do
  before(:each) do
    assign(:shift_matches, [
      ShiftMatch.create!(
        shift: nil,
        match: nil,
        notes: "Notes"
      ),
      ShiftMatch.create!(
        shift: nil,
        match: nil,
        notes: "Notes"
      )
    ])
  end

  it "renders a list of shift_matches" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Notes".to_s, count: 2
  end
end
