require 'rails_helper'

RSpec.describe Category do
  describe '#lineage' do
    subject { category.lineage }

    context 'with no parent or child' do
      let(:category) { build :category, name: 'branch' }

      it { is_expected.to eq %w[branch] }
    end

    context 'with a parent category' do
      let(:parent)   { build :category, name: 'root' }
      let(:category) { build :category, name: 'branch', parent: parent }

      it { is_expected.to eq %w[root branch] }
    end

    context 'with parent and child categories' do
      let(:parent)   { build :category, name: 'root' }
      let(:category) { build :category, name: 'branch', parent: parent }
      let(:child)    { build :category, name: 'leaf', parent: 'category' }

      it { is_expected.to eq %w[root branch] }
    end
  end
end
