require 'rails_helper'

RSpec.describe "shift_matches/show", type: :view do
  before(:each) do
    @shift_match = assign(:shift_match, ShiftMatch.create!(
      shift: nil,
      match: nil,
      notes: "Notes"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes/)
  end
end
