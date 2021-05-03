require 'spec_helper'

RSpec.describe HideRestrictedFieldsTransformer do
  let(:current_user) do
    FactoryBot.build(:user, id: 42)
  end

  let(:object) { model.new(name: 'person-name', location: FactoryBot.build(:location)) }

  subject(:serialize) do
    PersonBlueprint.render_as_hash(object, view: :with_location, current_user: current_user)
  end

  context 'when serializing an object without a policy' do
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

  context 'when serializing an object with a policy that implements `restricted_attributes`' do
    let(:model) { Person }

    it { is_expected.to include(name: nil) }
    it { is_expected.to include(location: nil) }
  end

  context 'when serializing an object with a policy that does not implement `restricted_attributes`' do
    let(:model) { Person }

    before do
      PersonPolicy.alias_method(:orig_restricted_attributes, :restricted_attributes)
      PersonPolicy.undef_method(:restricted_attributes)
    end

    after do
      PersonPolicy.alias_method(:restricted_attributes, :orig_restricted_attributes)
      PersonPolicy.undef_method(:orig_restricted_attributes)
    end

    specify 'serialization works transparently' do
      expect(PersonPolicy).not_to respond_to(:restricted_attributes)
      expect { serialize }.not_to raise_error
    end
  end

  context 'when serializing the parent of an object with restricted_attributes' do
    let(:parent) { FactoryBot.build(:ask, person: FactoryBot.build(:person)) }

    subject do
      ListingBlueprint.render_as_hash(parent, view: :with_person, current_user: current_user)[:person]
    end

    it { is_expected.to include(name: nil) }
  end
end
