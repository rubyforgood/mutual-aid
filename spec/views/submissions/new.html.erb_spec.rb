require 'rails_helper'

RSpec.describe "submissions/new", type: :view do
  let(:person) { create(:person) }
  let(:service_area) { create(:service_area) }
  before(:each) do
    assign(:submission, create(:submission,
                               person: person,
                               service_area: service_area,
                               form_name: "MyString",
                               body: "MyText"
    ))
  end

  it "renders new submission form" do
    render

    # assert_select "form[action=?][method=?]", submissions_path, "post" do

      assert_select "select[name=?]", "submission[person_id]"

      assert_select "select[name=?]", "submission[service_area_id]"

      assert_select "input[name=?]", "submission[form_name]"
    # end
  end
end
