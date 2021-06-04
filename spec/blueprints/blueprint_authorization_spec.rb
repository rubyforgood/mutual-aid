require 'spec_helper'

RSpec.describe 'Blueprint authorization' do
  let(:current_user) do
    FactoryBot.build(:user, id: 42)
  end

  context 'when serializing with authorization' do
    let(:object) { FactoryBot.build(:person, id: 21, name: 'person-name', location: FactoryBot.build(:location)) }

    let(:serialized_hash) do
      PersonBlueprint.render_as_hash(object, current_user: current_user)
    end

    it 'nullifies restricted attributes' do
      expect(serialized_hash).to include(name: nil)
    end

    it 'leaves public attributes as is' do
      expect(serialized_hash).to include(id: 21)
    end

    context 'with a specified view' do
      let(:serialized_hash) do
        PersonBlueprint.render_as_hash(object, view: :with_location, current_user: current_user)
      end

      it 'nullifies restricted attributes in the root object' do
        expect(serialized_hash).to include(name: nil)
      end

      it 'nullifies restricted attributes in views' do
        expect(serialized_hash).to include(location: nil)
      end
    end
  end

  context 'when serializing the parent of a blueprint with authorization' do
    let(:parent) { FactoryBot.build(:ask, person: FactoryBot.build(:person)) }

    let(:serialized_hash) do
      ListingBlueprint.render_as_hash(parent, view: :with_person, current_user: current_user)
    end

    it 'nullifies restricted attributes in the nested object' do
      expect(serialized_hash[:person]).to include(name: nil)
    end
  end
end
