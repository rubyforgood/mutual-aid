require 'rails_helper'

RSpec.describe SaveListing do
  let(:service_area)    { create :service_area }
  let(:contact_method)  { create :contact_method_email }
  subject(:interaction) { SaveListing.run params }

  describe 'validation' do
    let(:params) {{
      description: '',
      title: '',
      type: '', # this is invalid
      service_area: service_area.id,
      person: {
        preferred_contact_method: contact_method.id,
        email: 'we@together.coop',
        phone: '',
        location: {
          street_address: '',
          neighborhood: '',
          city: 'Lansing',
          state: 'MI',
          zip: '',
          county: '',
          region: '',
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

