# == Schema Information
#
# Table name: location_types
#
#  id                :bigint           not null, primary key
#  description       :string
#  display_to_public :boolean          default(FALSE), not null
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_location_types_on_display_to_public  (display_to_public)
#
require 'rails_helper'

RSpec.describe LocationType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
