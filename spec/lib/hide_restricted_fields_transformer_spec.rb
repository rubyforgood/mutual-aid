require 'spec_helper'

RSpec.describe HideRestrictedFieldsTransformer do
  let(:current_user) do
    FactoryBot.build(:user, id: 42)
  end

  let(:object) { model.new(name:'person-name', location: FactoryBot.build(:location)) }

  subject do
    PersonBlueprint.render_as_hash(object, view: :with_location, current_user: current_user)
  end

  context 'when serializing an object with no policy' do
    let(:model) do
      Class.new(Person) do
        def policy_class
          nil
        end
      end
    end

    it { is_expected.to include(name: 'person-name') }
    it { is_expected.to include(:location) }
  end

  context 'when serializing an object with a policy' do
    let(:model) { Person }

    it { is_expected.to include(name: nil) }
    it { is_expected.to include(location: nil) }
  end
end
