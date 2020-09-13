class ContactMethod < ApplicationRecord
  has_many :people, inverse_of: :preferred_contact_method, foreign_key: :preferred_contact_method_id, dependent: :restrict_with_error

  scope :as_filter_types, -> { enabled.distinct(:name) }
  scope :email, -> { find_by name: 'Email' }
  scope :enabled, -> { where enabled: true }
  scope :field_name, -> (field_name){ where arel_table[:field].lower.eq(field_name) }
  scope :method_name, -> (method_name){ where arel_table[:name].lower.eq(method_name) }
  scope :sample_one, -> { order(Arel.sql('RANDOM()')).first }

  def self.map_common_names_to_fields(name)
    name.downcase == 'email' ? 'email' : 'phone'
  end

  def label
    I18n.t field, scope: [:models, :contact_method, :labels]
  end
end

# == Schema Information
#
# Table name: contact_methods
#
#  id         :bigint           not null, primary key
#  enabled    :boolean          default(TRUE), not null
#  field      :string
#  icon_class :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_contact_methods_on_enabled  (enabled)
#
