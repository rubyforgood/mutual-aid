require 'rails_helper'

RSpec.describe SaveListing do
  let(:service_area)    { create :service_area }
  subject(:interaction) { SaveListing.run params }

  describe 'validation' do
    let(:params) {{
      type: '',  # only Listing field with validation
      service_area: service_area.id,
      person: {
        preferred_contact_method: 'email',
        email: 'we@together.coop',
        location: {
          city: 'Lansing',
          state: 'MI',
        },
      },
    }}

    it { is_expected.to be_invalid }

    it 'does not create any records' do
      expect { interaction }
        .to  change(Listing,  :count).by(0)
        .and change(Person,   :count).by(0)
        .and change(Location, :count).by(0)
    end

    it 'gathers errors from nested objects' do
      expect(interaction.errors.full_messages).to eq ["Type can't be blank"]
    end
  end
end

