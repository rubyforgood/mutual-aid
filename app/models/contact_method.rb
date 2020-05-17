class ContactMethod < ApplicationRecord
  has_many :people, inverse_of: :preferred_contact_method, foreign_key: :preferred_contact_method_id, dependent: :restrict_with_error

  scope :autoemail, -> (boolean){ where( boolean ? arel_table[:name].lower.eq("autoemail") : arel_table[:name].lower.not_eq("autoemail") ) }
  scope :enabled, -> { where enabled: true }
  scope :name, -> (name){ where arel_table[:name].lower.eq(name) }
  scope :public, ->{ autoemail(false).enabled }

  scope :as_filter_types, -> { public.distinct(:name) }

  def label
    I18n.t field, scope: [:models, :contact_method, :labels]
  end
end
