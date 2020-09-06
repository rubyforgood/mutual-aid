# == Schema Information
#
# Table name: shifts
#
#  id         :bigint           not null, primary key
#  ended_at   :datetime
#  notes      :text
#  started_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint           not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_shifts_on_person_id  (person_id)
#  index_shifts_on_team_id    (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (team_id => teams.id)
#
require 'rails_helper'

RSpec.describe Shift, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
