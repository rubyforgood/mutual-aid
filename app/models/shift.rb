class Shift < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :team

  has_many :matches

  def name
    "#{team&.name}: #{times}"
  end

  def times
    # %a, %B %d,
        # shift.started_at&.strftime("%a, %B %d, %Y at %l:%M %P") %> - <%= shift.ended_at&.strftime("%a, %B %d, %Y at %l:%M %P")
    hide_starting_p = started_at&.strftime("%p") == ended_at&.strftime("%p") ? true : false
    "#{started_at.strftime("%a %B %d %Y, %l:%M")} #{started_at.strftime("%P") unless hide_starting_p} - #{ended_at&.strftime("%l:%M %P")}"
  end
end
