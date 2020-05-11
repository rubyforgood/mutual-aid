class ContactMethod < ApplicationRecord
  has_many :people, dependent: :restrict_with_error

  scope :enabled, -> { where enabled: true }

  def label
    I18n.t field, scope: [:models, :contact_method, :labels]
  end
end
