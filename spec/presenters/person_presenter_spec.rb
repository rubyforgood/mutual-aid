require 'rails_helper'

RSpec.describe PersonPresenter do
  let(:person)       { build :person, name: 'James Brown' }
  let(:context)      { Context.new user: current_user  }
  let(:view_context) { double 'ViewContext', context: context }
  let(:presenter)    { PersonPresenter.new person, view_context }

  describe 'name' do
    subject { presenter.name }

    context 'when current user is authorized to see people names' do
      let(:current_user) { build :user, :admin }

      it { is_expected.to eql 'James Brown' }
    end

    context 'when current user is not authorized to see people names' do
      let(:current_user) { build :user, :neighbor }

      it { is_expected.to be nil }
    end
  end
end
