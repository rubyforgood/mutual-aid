require 'rails_helper'

describe '/admin', type: :request do
  before do
    sign_in create(:user, :admin)
  end

  describe 'GET /glossary' do
    it 'renders a successful response' do
      get glossary_admin_url
      expect(response).to be_successful
    end
  end

  describe 'GET /glossary_edit' do
    it 'renders a successful response' do
      get glossary_admin_edit_url
      expect(response).to be_successful
    end
  end

  describe 'PATCH /glossary_edit' do
    let(:system_settings) { (FactoryBot.create :system_setting) }
    let(:glossary_html) { "<b>Word</b>: Definition" }

    it 'does not update the glossary_content if system_setting object is missing' do
      patch glossary_admin_update_url(), params: { system_setting: { glossary_content: glossary_html }}
      expect(system_settings.glossary_content.body).to be_nil
    end

    it 'updates glossary_content of the system_setting object' do
      patch glossary_admin_update_url(system_settings), params: { system_setting: { glossary_content: glossary_html} }
      expect(response.status).to eq 302
      expect(system_settings.glossary_content.body).not_to be_nil
    end
  end
end
