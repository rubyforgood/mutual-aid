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

# == Schema Information
#
# Table name: mobility_text_translations
#
#  id                :bigint           not null, primary key
#  is_approved       :boolean          default(TRUE), not null
#  key               :string           not null
#  locale            :string           not null
#  translatable_type :string
#  value             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by_id     :bigint
#  translatable_id   :bigint
#
# Indexes
#
#  index_mobility_text_translations_on_created_by_id           (created_by_id)
#  index_mobility_text_translations_on_keys                    (translatable_id,translatable_type,locale,key) UNIQUE
#  index_mobility_text_translations_on_translatable_attribute  (translatable_id,translatable_type,key)
#
