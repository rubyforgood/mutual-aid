require 'rails_helper'

RSpec.describe "positions/edit", type: :view do
  before(:each) do
    @view_action_name = "edit"
    @position = create(:position)
  end

  it "renders the edit position form" do
    render

    assert_select "#position_description"
    assert_select "#position_start_date_1i"
    assert_select "#position_end_date_1i"
    assert_select "#position_person_id"
    assert_select "#position_organization_id"
    assert_select "#position_is_primary"
    assert_select "#position_notes"

    assert_select "form input" do
      assert_select "input[id=?]", "position_name"

    end
  end
end
