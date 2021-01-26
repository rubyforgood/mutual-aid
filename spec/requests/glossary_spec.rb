require 'rails_helper'

describe '/glossary', type: :request do
  let!(:system_setting) { FactoryBot.create :system_setting, glossary_content: 'Original text' }

  describe 'GET /glossary' do
    it 'renders a successful response with the current content' do
      get glossary_url
      expect(response).to be_successful
      expect(response.body).to include 'Original text'
    end
  end

  context "when user is signed in" do
    before do
      sign_in create(:user, :admin)
    end

    describe 'GET /glossary/edit' do
      it 'renders a successful response with the current content' do
        get edit_glossary_url
        expect(response).to be_successful
        expect(response.body).to include 'Original text'
      end
    end

    describe 'PATCH /glossary' do
      let(:new_html) { "<b>Word</b>: Definition" }

      it 'updates glossary_content of the system_setting object' do
        patch glossary_url, params: { system_setting: { glossary_content: new_html } }
        expect(response.status).to eq 302
        expect(system_setting.reload.glossary_content.to_s).to include new_html
      end
    end
  end
end
