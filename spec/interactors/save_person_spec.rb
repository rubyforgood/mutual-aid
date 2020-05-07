require 'rails_helper'

RSpec.describe SavePerson do
  let(:current_location) { create :location, city: 'flint' }
  let(:current_person)   { create :person, location: current_location }

  let(:params) {{
    id: current_person&.id,
    preferred_contact_method: 'email',
    email: 'we@together.coop',
    location: {
      id: current_location&.id,
      city: '',
      state: 'DC', # statehood now!
    },
  }}

  let(:interaction) { SavePerson.run params }
  let(:person)      { interaction.result }

  describe 'modification' do
    it 'updates the current person and associated location' do
      expect(person).to eq(current_person.reload)
      expect(person.location).to eq current_location.reload
    end

    it 'allows for existing fields to be nullified' do
      expect(person.location.city).to be_empty
    end

    context 'when params include a person.id but no location.id' do
      let(:current_location) { nil }

      it 'fails' do
        expect { interaction }.to raise_error(/Missing location.id/)
      end
    end
  end

  describe 'creation' do
    let(:current_person)   { nil }
    let(:current_location) { nil }

    it 'creates a person' do
      expect(person).to be_persisted
    end

    it 'creates a nested location' do
      expect(person.location).to be_persisted
      expect(person.location.state).to eq 'DC'
    end

    context 'with invalid location params' do
      before { params[:location][:state] = '' }

      it 'makes the parent interaction invalid' do
        expect(interaction).to be_invalid
      end

      it 'does not create either record' do
        expect { interaction }
          .to  change(Person, :count).by(0)
          .and change(Location, :count).by(0)
      end

      it 'promotes nested errors' do
        expect(interaction.errors.full_messages).to eq ["State can't be blank"]
      end
    end

    context 'with invalid person params' do
      before { params[:email] = '' }

      it 'does not create either record' do
        expect { interaction }
          .to  change(Person, :count).by(0)
          .and change(Location, :count).by(0)
      end
    end
  end
end
