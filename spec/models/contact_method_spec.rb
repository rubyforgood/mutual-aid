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
require 'rails_helper'

RSpec.describe ContactMethod, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
