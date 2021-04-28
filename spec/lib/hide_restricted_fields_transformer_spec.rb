require 'spec_helper'

RSpec.describe HideRestrictedFieldsTransformer do
  let(:current_user) do
    FactoryBot.build(:user, id: 42)
  end

  let(:unrestricted_model) do
    Class.new(Person) do
      def policy_class
        nil
      end
    end
  end

  subject do
    PersonBlueprint.render_as_hash(object, current_user: current_user)
  end

  context 'when serializing an object with no policy' do
    let(:object) { unrestricted_model.new name:('person-name') }

    it { is_expected.to include(name: 'person-name') }
  end

  context 'when serializing an object with a policy' do
    let(:object) { Person.new(name: 'person-name') }

    it { is_expected.to include(name: nil) }
  end
end
