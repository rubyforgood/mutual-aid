class ContactMethod < ApplicationRecord
  has_many :people, inverse_of: :preferred_contact_method, foreign_key: :preferred_contact_method_id, dependent: :restrict_with_error

  scope :as_filter_types, -> { public.distinct(:name) }
  scope :autoemail, -> (boolean){ where( boolean ? arel_table[:name].lower.eq("autoemail") : arel_table[:name].lower.not_eq("autoemail") ) }
  scope :enabled, -> { where enabled: true }
  scope :enabled_public, ->{ enabled.autoemail(false) }
  scope :field_name, -> (field_name){ where arel_table[:field].lower.eq(field_name) }
  scope :method_name, -> (method_name){ where arel_table[:name].lower.eq(method_name) }

  def label
    I18n.t field, scope: [:models, :contact_method, :labels]
  end
end
