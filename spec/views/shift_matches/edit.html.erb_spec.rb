require 'rails_helper'

RSpec.describe "shift_matches/edit", type: :view do
  before(:each) do
    @shift_match = assign(:shift_match, ShiftMatch.create!(
      shift: nil,
      match: nil,
      notes: "MyString"
    ))
  end

  it "renders the edit shift_match form" do
    render

    assert_select "form[action=?][method=?]", shift_match_path(@shift_match), "post" do

      assert_select "input[name=?]", "shift_match[shift_id]"

      assert_select "input[name=?]", "shift_match[match_id]"

      assert_select "input[name=?]", "shift_match[notes]"
    end
  end
end
