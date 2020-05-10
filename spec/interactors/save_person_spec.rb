require 'rails_helper'

RSpec.describe SavePerson do
#   let(:contact_method)   { create :contact_method_email }
#   let(:current_location) { create :location, city: 'flint' }
#   let(:current_person)   { create :person, location: current_location }
#
#   let(:params) {{
#     id: current_person&.id,
#     preferred_contact_method: contact_method.id,
#     email: 'we@together.coop',
#     name: 'Harriet Tubman',
#     location: {
#       id: current_location&.id,
#       state: 'DC', # statehood now!
#       location_type: current_location.location_type.id
#     },
#   }}
#
#   let(:interaction) { SavePerson.run params }
#   let(:person)      { interaction.result }
#
#   describe 'modification' do
#     it 'updates the current person and associated location' do
#       skip # TODO fix this
#       expect(person).to eq(current_person.reload)
#       expect(person.location).to eq current_location.reload
#     end
#
#     it 'allows for existing fields to be nullified' do
#       params[:location][:city] = nil
#       skip # TODO fix this
#       expect(person.location.city).to be_nil
#     end
#
#     context 'when params include a person.id but no location.id' do
#       let(:current_location) { nil }
#
#       it 'fails' do
#         skip # TODO fix this
#         expect { interaction }.to raise_error(/Missing location.id/)
#       end
#     end
#   end
#
#   describe 'creation' do
#     let(:current_person)   { nil }
#     let(:current_location) { nil }
#
#     it 'creates a person' do
#       skip # TODO fix this
#       expect(person).to be_persisted
#     end
#
#     it 'creates a nested location' do
#       skip # TODO fix this
#       expect(person.location).to be_persisted
#       expect(person.location.state).to eq 'DC'
#     end
#
#     context 'with invalid location params' do
#       before { params[:location][:location_type_id] = '' }
#
#       it 'makes the parent interaction invalid' do
#         expect(interaction).to be_invalid
#       end
#
#       it 'does not create either record' do
#         expect { interaction }
#           .to  change(Person, :count).by(0)
#           .and change(Location, :count).by(0)
#       end
#
#       it 'promotes nested errors' do
#         expect(interaction.errors.full_messages).to eq ["Location type is required"]
#       end
#     end
#
#     context 'with invalid person params' do
#       before { params[:email] = '' }
#
#       it 'does not create either record' do
#         skip # TODO fix this
#         expect { interaction }
#           .to  change(Person, :count).by(0)
#           .and change(Location, :count).by(0)
#       end
#     end
#   end
end
