class SubmissionBlueprint < Blueprinter::Base
  identifier :id

  association :service_area, blueprint: ServiceAreaBlueprint

  association :person, blueprint: PersonBlueprint

  association :location, blueprint: LocationBlueprint, view: :with_location_type do |submission|
    submission&.person&.location
  end

  association :listings, blueprint: ListingBlueprint

  field :errors do |submission|
    submission.errors.as_json(full_messages: true)
  end
end
