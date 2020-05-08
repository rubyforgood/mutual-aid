class SoftwareFeedback < ApplicationRecord
  belongs_to :created_by, optional: true, class_name: "User", foreign_key: :created_by_id
end
