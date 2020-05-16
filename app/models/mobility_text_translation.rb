class MobilityTextTranslation < ApplicationRecord
  
  belongs_to :translatable, polymorphic: true
  belongs_to :created_by, class_name: "User", optional: true

  validates :locale, presence: true
  validates :key, presence: true
  validates :value, presence: true

  validates :translatable_id, uniqueness: { scope: [:translatable_type, :locale, :key] }

  scope :translatable, ->(record) { where(translatable_id: record.id).where(translatable_type: record.class.to_s) }
  scope :locale, ->(locale) { where("locale ILIKE ?", locale) }
  scope :key, ->(key) { where("key ILIKE ?", key) }
  scope :value, ->(value) { where("value ILIKE ?", value) }
end
