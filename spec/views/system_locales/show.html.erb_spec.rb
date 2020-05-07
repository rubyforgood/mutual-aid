require 'rails_helper'

RSpec.describe "system_locales/show", type: :view do
  before(:each) do
    @system_locale = assign(:system_locale, SystemLocale.create!(
      locale: "Locale",
      locale_name: "Locale Name",
      publish_in_dropdowns: false,
      publish_translations: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Locale/)
    expect(rendered).to match(/Locale Name/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
