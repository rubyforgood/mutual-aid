class SubmissionForm < BaseForm
  hash :responses_attributes, strip: false, default: {}

  with_options default: nil do
    integer :id
    record  :service_area
    hash    :listings_attributes,  strip: false
    hash    :location_attributes,  strip: false
    hash    :person_attributes,    strip: false
    string  :form_name
    string  :privacy_level_requested  # fixme: not submitted as yet
  end

  def execute
    build_location
    build_person
    build_listings
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

    def build_listings
      @listings = (listings_attributes[:categories] || []).map do |category_id|
        ListingForm.build listings_attributes.merge(
          category: category_id,
          location: @location,
          person: @person,
          service_area: service_area,
        )
      end
    end

    def build_submission
      submission.tap do |submission|
        # todo: this has to be smarter if we want to support partial updates
        submission.attributes = submission_attributes
      end
    end

    def build_submission_responses
      @submission_responses = responses_attributes.map do |(custom_form_question_id, answer)|
        SubmissionResponseForm.build(
          submission: submission,
          custom_form_question_id: custom_form_question_id,
          string_response: answer,
        )
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
          listings: @listings,
          submission_responses: @submission_responses,
        )
    end

    def body_json
      given_inputs
        .merge(service_area: service_area.id)
        .to_json
    end

    def submission
      @submisson ||= Submission.find_or_new(id)
    end
end
