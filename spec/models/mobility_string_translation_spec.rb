# == Schema Information
#
# Table name: mobility_string_translations
#
#  id                :bigint           not null, primary key
#  is_approved       :boolean          default(TRUE), not null
#  key               :string           not null
#  locale            :string           not null
#  translatable_type :string
#  value             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by_id     :bigint
#  translatable_id   :bigint
#
# Indexes
#
#  index_mobility_string_translations_on_created_by_id           (created_by_id)
#  index_mobility_string_translations_on_keys                    (translatable_id,translatable_type,locale,key) UNIQUE
#  index_mobility_string_translations_on_query_keys              (translatable_type,key,value,locale)
#  index_mobility_string_translations_on_translatable_attribute  (translatable_id,translatable_type,key)
#
require 'rails_helper'

RSpec.describe MobilityStringTranslation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
