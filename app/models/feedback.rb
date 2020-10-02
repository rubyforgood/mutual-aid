class Feedback < ApplicationRecord
  belongs_to :match
end

# == Schema Information
#
# Table name: feedbacks
#
#  id               :bigint           not null, primary key
#  completed        :boolean          default(FALSE), not null
#  description      :text
#  is_from_receiver :boolean          default(TRUE), not null
#  quality          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  match_id         :bigint           not null
#
# Indexes
#
#  index_feedbacks_on_match_id  (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#
