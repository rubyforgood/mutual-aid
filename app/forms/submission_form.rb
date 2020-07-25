class SubmissionForm < BaseForm
  with_options default: nil do
    integer :id
    record  :service_area
    hash    :listing_attributes,   strip: false
    hash    :location_attributes,  strip: false
    hash    :person_attributes,    strip: false
    hash    :responses_attributes, strip: false
    string  :form_name
    string  :privacy_level_requested  # fixme: not submitted as yet
  end

  def execute
    build_location
    build_person
    build_listing
    build_submission_responses
    build_submission
  end

  private

    def build_location
      @location ||= LocationForm.build location_attributes
    end

    def build_person
      @person ||= PersonForm.build person_attributes.merge location: @location
    end

    def build_listing
      @listing ||= ListingForm.build listing_attributes.merge(
        person: @person,
        location: @location,
        service_area: service_area
      )
    end

    def build_submission
      (id? ? Submission.find(id) : Submission.new).tap do |submission|
        submission.attributes = submission_attributes
      end
    end

    def build_submission_responses
      @submission_responses = responses_attributes.each_with_object([]) do |(custom_form_question_id, answer), obj|
        response = SubmissionResponseForm.build custom_form_question_id: custom_form_question_id,
                                                string_response: answer
        obj << response
      end
    end

    def submission_attributes
      given_inputs
        .slice(
          :form_name,
          :privacy_level_requested,
          :service_area,
        )
        .merge(
          body: body_json,
          person: @person,
          listings: [@listing],
          submission_responses: @submission_responses,
        )
    end

    def body_json
      given_inputs
        .merge(service_area: service_area.id)
        .to_json
    end
end
