class Shift < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :team

  has_many :shift_matches
  has_many :matches, through: :shift_matches

  scope :active, ->() { where("started_at >= ?", Time.now) }
  scope :today, ->() { where("started_at::date = ?", Date.today.strftime("%Y-%m-%d")) }

  def name
    "#{team&.name}: #{times} #{"(" + person.name + ")" if person_id}"
  end

  def times
    hide_starting_p = started_at&.strftime("%p") == ended_at&.strftime("%p") ? true : false
    "#{started_at&.strftime("%a at %l:%M")} #{started_at&.strftime("%P") unless hide_starting_p} - #{ended_at&.strftime("%l:%M %P") || ("TBD" if started_at.present?)}#{started_at&.strftime(", %B %d %Y")}"
  end
end
