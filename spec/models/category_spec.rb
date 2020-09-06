# == Schema Information
#
# Table name: categories
#
#  id                  :bigint           not null, primary key
#  description         :string
#  display_order       :integer          default(10), not null
#  display_to_public   :boolean          default(TRUE), not null
#  is_created_by_admin :boolean          default(FALSE), not null
#  name                :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  parent_id           :bigint
#
# Indexes
#
#  index_categories_on_description          (description)
#  index_categories_on_display_order        (display_order)
#  index_categories_on_display_to_public    (display_to_public)
#  index_categories_on_is_created_by_admin  (is_created_by_admin)
#  index_categories_on_name                 (name)
#  index_categories_on_parent_id            (parent_id)
#
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
