class ContactMethod < ApplicationRecord
  has_many :people, inverse_of: :preferred_contact_method, foreign_key: :preferred_contact_method_id, dependent: :restrict_with_error

  scope :enabled, -> { where enabled: true }
  scope :as_filter_types, -> { enabled.distinct(:name) }

  def label
    I18n.t field, scope: [:models, :contact_method, :labels]
  end
end
