require 'rails_helper'

RSpec.describe "/", type: :request do
  it 'has text populated from system_setting' do
    expected_who_text = Faker::Lorem.sentence
    new_system_setting = build(:system_setting, landing_page_text_who: expected_who_text)
    expect(SystemSetting).to receive(:first).and_return new_system_setting

    get '/'

    # assert
  end

end
