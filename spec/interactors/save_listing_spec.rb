require 'rails_helper'

RSpec.describe SaveListing do
  let(:service_area)    { create :service_area }
  let(:contact_method)  { create :contact_method_email }
  subject(:interaction) { SaveListing.run params }

  let(:params) {{
    service_area: service_area.id,
    type: 'Offer',
    person: {
      email: 'we@together.coop',
      name: 'Marcus Garvey',
      preferred_contact_method: contact_method.id,
      location: {
        city: 'Lansing',
        state: 'MI',
      },
    },
  }}

  context 'with valid params' do
    it { is_expected.to be_valid }

    it 'create listing and nested records' do
      expect { interaction }
        .to  change(Listing,  :count).by(1)
        .and change(Person,   :count).by(1)
        .and change(Location, :count).by(1)
    end
  end

  context 'with bad listing params' do
    before { params[:type] = '' }

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

