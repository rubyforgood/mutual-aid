require 'rails_helper'

RSpec.describe "submissions/edit", type: :view do
  let(:person) { create(:person) }
  let(:service_area) { create(:service_area) }
  before(:each) do
    @submission = create(:submission,
                         person: person,
                         service_area: service_area,
                         form_name: "MyString",
                         body: "MyText"
    )
  end

  it "renders the edit submission form" do
    render

    assert_select "form[action=?][method=?]", submission_path(@submission), "post" do

      assert_select "select[name=?]", "submission[person_id]"

      assert_select "select[name=?]", "submission[service_area_id]"

      assert_select "input[name=?]", "submission[form_name]"
    end
  end
end
