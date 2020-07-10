class ListingForm < BaseForm
  with_options default: nil do
    integer :id
    record  :person
    record  :location
    record  :service_area
    array   :tag_list, default: []  # todo now: rename
    string  :description
    string  :state
    string  :type
  end

  def execute
    Listing.find_or_new(id).tap do |listing|
      tags = Category.where(id: tag_list).pluck(:name)
      listing.attributes = given_inputs.merge(tag_list: tags)
    end
  end
end
