require 'rails_helper'

RSpec.describe "/people", type: :request do
  before { sign_in FactoryBot.create(:user, :sys_admin) }

  describe 'GET /index' do
    let!(:people) { create_list(:person, 40) }

    it 'renders a successful response' do
      get people_url
      expect(response).to be_successful
    end

    it 'paginates results' do
      get people_url
      people_links = response.body.scan %r{href="/people/\d+/.+"}
      expect(people_links.size).to eq Pagy::VARS[:items]
    end
  end

  describe "GET /show" do
    let(:person) { FactoryBot.create(:person) }

    it "can render" do
      get "/people/#{person.id}"
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "can render" do
      get "/people/new"
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    let(:person) { FactoryBot.create(:person) }

    it "can render" do
      get "/people/#{person.id}/edit"
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "can render" do
      post "/people", params: { person: FactoryBot.attributes_for(:person) }
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    let(:person) { FactoryBot.create(:person) }

    it "updates the person" do
      patch "/people/#{person.id}", params: { person: { name: "Aud Torvingen" } }
      person.reload
      expect(person.name).to eq("Aud Torvingen")
    end
  end

  describe "DELETE /destroy" do
    # we need to eager-create Person so that the Person is created
    # before the `Person.count` block.
    let!(:person) { FactoryBot.create(:person) }

    it "deletes the person" do
      expect {
        delete "/people/#{person.id}"
      }.to change {
        Person.count
      }.by(-1)
    end
  end
end
