class ExternalResource < ApplicationRecord
  taggable_array :tags

  belongs_to :location, optional: true

  def displaying_on_website?
    now = Time.now
    reviewed &&
    (display_on_website_start.present? ? display_on_website_start <= now : true) &&
      (display_on_website_end == nil || now < display_on_website_end)
  end

end
