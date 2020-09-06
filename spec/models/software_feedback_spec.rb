# == Schema Information
#
# Table name: software_feedbacks
#
#  id            :bigint           not null, primary key
#  completed     :boolean          default(FALSE), not null
#  completed_at  :datetime
#  feedback_type :string
#  module_name   :string
#  name          :string           not null
#  notes         :string
#  page_url      :string
#  urgency       :string
#  urgency_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :bigint
#
# Indexes
#
#  index_software_feedbacks_on_completed      (completed)
#  index_software_feedbacks_on_created_by_id  (created_by_id)
#
require 'rails_helper'

RSpec.describe SoftwareFeedback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
