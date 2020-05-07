require 'rails_helper'

RSpec.describe "system_locales/edit", type: :view do
  before(:each) do
    @system_locale = assign(:system_locale, SystemLocale.create!(
      locale: "MyString",
      locale_name: "MyString",
      publish_in_dropdowns: false,
      publish_translations: false
    ))
  end

  it "renders the edit system_locale form" do
    render

    assert_select "form[action=?][method=?]", system_locale_path(@system_locale), "post" do

      assert_select "input[name=?]", "system_locale[locale]"

      assert_select "input[name=?]", "system_locale[locale_name]"

      assert_select "input[name=?]", "system_locale[publish_in_dropdowns]"

      assert_select "input[name=?]", "system_locale[publish_translations]"
    end
  end
end
