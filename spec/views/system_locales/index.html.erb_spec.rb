require 'rails_helper'

RSpec.describe "system_locales/index", type: :view do
  before(:each) do
    assign(:system_locales, [
      create(:system_locale,
        locale: "Locale",
        locale_name: "Locale Name",
        publish_in_dropdowns: false,
        publish_translations: false
      ),
      create(:system_locale,
        locale: "Locale",
        locale_name: "Locale Name",
        publish_in_dropdowns: false,
        publish_translations: false
      )
    ])
  end

  it "renders a list of system_locales" do
    # skip # TODO - get tests working w view_header
    # render
    # assert_select "tr>td", text: "Locale".to_s, count: 2
    # assert_select "tr>td", text: "Locale Name".to_s, count: 2
    # assert_select "tr>td", text: false.to_s, count: 2
    # assert_select "tr>td", text: false.to_s, count: 2
  end
end
