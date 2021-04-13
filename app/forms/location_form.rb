# frozen_string_literal: true

class LocationForm < BaseForm
  with_options default: nil do
    integer :id
    integer :location_type
    string  :street_address
    string  :neighborhood
    string  :city
    string  :state
    string  :zip
    string  :county
    string  :region
  end

  def execute
    return nil if inputs.values.all?(&:blank?)

    Location.find_or_new(id).tap do |location|
      location.attributes = given_inputs_without_location_type
      location.location_type_id = location_type if given?(:location_type)
    end
  end

  private

  def given_inputs_without_location_type
    given_inputs.reject { |key| key == :location_type }
  end
end
