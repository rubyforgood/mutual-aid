class Match < ApplicationRecord
  belongs_to :receiver, polymorphic: true, inverse_of: :matches_as_receiver
  belongs_to :provider, polymorphic: true, inverse_of: :matches_as_provider
  belongs_to :shift, optional: true

  has_many :communication_logs
  has_many :feedbacks

  INITIATORS = ["receiver", "provider"]
  STATUSES = ["needs_follow_up", "matched_tentatively", "matched", "match_completed", "feedback_needed", "feedback_received", "feedback_completed"]

  # belongs_to :coordinator, optional: true #, class_name: "Position" # TODO
  #

  scope :status, ->(status) { where(status == "all" || status == nil ? "id IS NOT NULL" : "status = '#{status.downcase}'") }
  scope :this_month, -> { where("matches.created_at >= ? AND matches.created_at <= ?",
                                Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }

  def name
    "#{"[#{status}] "}#{receiver.name} & #{provider.name}"
  end

  def person_names # TODO move this to presenter
    receiver_name = [Listing, Ask, Offer].include?(receiver.class) ? receiver.person&.name : receiver.name if receiver
    provider_name = [Listing, Ask, Offer].include?(provider.class) ? provider.person&.name : provider.name if provider
    "#{receiver_name} -and- #{provider_name}" # TODO need to adjust for community resource
  end

  def short_name
    "#{"[#{status}] "}#{person_names}"
  end

  def full_name
    "Connected on #{created_at.strftime('%m-%-d-%Y')}: #{name} #{receiver.all_tags_to_s}"
  end
end
