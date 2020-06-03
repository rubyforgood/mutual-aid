class ListingForm < BaseForm
  with_options default: nil do
    integer :id
    record  :person
    record  :location
    record  :service_area
    array   :tag_list, default: []
    string  :description
    string  :state
    string  :type
  end

  def execute
    (id? ? Listing.find(id) : Listing.new).tap do |listing|
      listing.attributes = given_inputs
    end
  end
end
