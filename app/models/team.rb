class Team < ApplicationRecord
  belongs_to :organization

  has_many :positions

  scope :org_chart, -> { where(display_on_org_chart: true) }
end
