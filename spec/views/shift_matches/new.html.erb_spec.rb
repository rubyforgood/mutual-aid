require 'rails_helper'

RSpec.describe "shift_matches/new", type: :view do
  before(:each) do
    assign(:shift_match, ShiftMatch.new(
      shift: nil,
      match: nil,
      notes: "MyString"
    ))
  end

  it "renders new shift_match form" do
    render

    assert_select "form[action=?][method=?]", shift_matches_path, "post" do

      assert_select "input[name=?]", "shift_match[shift_id]"

      assert_select "input[name=?]", "shift_match[match_id]"

      assert_select "input[name=?]", "shift_match[notes]"
    end
  end
end
