class ContactMethod < ApplicationRecord
  scope :enabled, -> { where enabled: true }

  def label
    I18n.t field, scope: [:models, :contact_method, :labels]
  end
end
