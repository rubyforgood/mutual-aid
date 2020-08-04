class ListingForm < BaseForm
  with_options default: nil do
    integer :id
    record  :category
    record  :location
    record  :person
    record  :service_area
    string  :description
    string  :state
    string  :type
  end

  def execute
    Listing.find_or_new(id).tap do |listing|
      listing.attributes = given_inputs.
        reject{ |k, _v| k == :category }.
        merge(tag_list: category.lineage)
    end
  end
end
