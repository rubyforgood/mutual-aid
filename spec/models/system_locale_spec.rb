# == Schema Information
#
# Table name: system_locales
#
#  id                   :bigint           not null, primary key
#  locale               :string           not null
#  locale_name          :string           not null
#  publish_in_dropdowns :boolean          default(TRUE), not null
#  publish_translations :boolean          default(TRUE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_system_locales_on_locale                (locale)
#  index_system_locales_on_publish_in_dropdowns  (publish_in_dropdowns)
#  index_system_locales_on_publish_translations  (publish_translations)
#
require 'rails_helper'

RSpec.describe SystemLocale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
