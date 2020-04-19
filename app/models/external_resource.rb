class ExternalResource < ApplicationRecord
  taggable_array :tags

  belongs_to :location, optional: true

  def published?
    now = Time.now
    approved &&
    (publish_from.present? ? publish_from <= now : true) &&
      (publish_until == nil || now < publish_until)
  end

end
