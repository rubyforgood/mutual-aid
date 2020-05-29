class SubmissionForm < BaseForm
  with_options default: nil do
    integer :id
    record  :service_area
    hash    :listing_attributes,  strip: false
    hash    :location_attributes, strip: false
    hash    :person_attributes,   strip: false
    string  :form_name
    string  :privacy_level_requested
  end

  def execute
    (id? ? Submission.find(id) : Submission.new).tap do |submission|
      submission.attributes = submission_attributes
    end
  end

  private

    def location
      @location ||= LocationForm.build location_attributes
    end

    def person
      @person ||= PersonForm.build person_attributes.merge location: location
    end

    def listing
      @listing ||= ListingForm.build listing_attributes.merge(
        person: person,
        location: location,
        service_area: service_area
      )
    end

    def submission_attributes
      given_inputs
        .slice(
          :form_name,
          :privacy_level_requested,
          :service_area,
        )
        .merge(
          person: person,
          listings: [listing],
        )
    end
end
