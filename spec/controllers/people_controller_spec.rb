require 'rails_helper'

describe PeopleController do
  before do
    sign_in create(:user)
  end

  describe '#index' do
    before do
      create_list(:person, 40)
    end

    it 'returns paginated people' do
      get :index
      expect(assigns(:people).length).to eq(Pagy::VARS[:items])
    end

    it 'sets the pagination ivar' do
      get :index
      expect(assigns(:pagy)).to_not eq(nil)
    end
  end
end
