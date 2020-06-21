
## Timestamp,
## "Name",
## "service_area_name",
## "phone",
## "email",
## "locale_name",
## "Have you tested positive for COVID-19coronavirus?",
## "Do you need aid or do you want to volunteer to provide aid?",
# "offer_category_errands",
# "offer_category_errands_funding",
# "offer_category_errands_funding_description",
# "offer_category_cash",
# "offer_category_cash_description",
# "offer_category_housing",
## "Are you interested in being a neighborhood steward?",
## "skills",
## "Questions/Comments/Suggestions?",
## "Signature of Volunteer/Needs Requester: Confirming that I am of legal age and am freely signing this agreement electronically. I have read this form and understand that by signing this form, I am giving up legal rights and remedies.",
# "urgency_level_name",
# "ask_category_groceries",
# "ask_category_groceries_funding",
# "ask_category_groceries_funding_description",
# "ask_category_groceries_diet_description",
# "ask_category_medication_delivery",
# "ask_category_medication_delivery_pharmacy_description",
# "ask_category_medication_delivery_funding",
# "ask_category_medication_delivery_funding",
# "ask_category_cash",
# "ask_category_cash_description",
# "ask_category_miscellaneous",
## "Can you share some ways you identify yourself? i.e class, race, gender identity, (dis)ability etc",
## "Has the COVID-19 (Corona virus) virus has affected you (directly or indirectly)? If yes, how?",
# "ask_category_bulk_descr",
## "Do you also want to volunteer to provide aid?",
## "Signature of Volunteer/Needs Requester: Confirming that I am of legal age and am freely signing this agreement electronically. I have read this form and understand that by signing this form, I am giving up legal rights and remedies."

class Importers::SubmissionResponseImporter < Importers::BaseImporter

  def initialize(current_user, form_type, categories_question_name=nil)
    require "#{Rails.root}/db/scripts/tuple_counts.rb"
    # audit_info(current_user) # TODO
    set_klasses
    establish_counts

    @current_user = current_user
    @custom_form_questions = []
    @form_type = form_type
    @categories_question_name = categories_question_name ||
      if form_type.include?("request")
        "What do you need? Check all that apply"
      elsif form_type.include?("offer")
        "What resources can you offer? check all applicable"
      end
    @current_organization = Organization.current_organization
    @organization_listing = create_organization_community_resource
  end

  def klasses_array
    [Submission, CustomFormQuestion, SubmissionResponse, Person]
  end

  def required_fields_array
    []
  end

  def primary_import_klass_name
    "Submission"
  end

  def is_row_header(row)
    ["timestamp"].include?(row["Timestamp"]&.downcase)
  end

  def process_headers_as_data(rows)
    rows.headers.each_with_index do |header_name, idx|
      if header_name # skip blank headers!
        puts header_name
        question = CustomFormQuestion.where("LOWER(name) = ?", header_name.downcase.strip).
                                      where(form_type: @form_type).
            # where.not(name: @categories_question_name). # TODO exclude categories answer from import
            first_or_create!(display_order: idx, input_type: "string", name: header_name.downcase.strip)
        question.update_attributes!(display_order: idx, input_type: "string") # in case question was already in db
        question.save!
        @custom_form_questions << question
      end
    end
  end

  def create_contact_method_from_row(row)
    preferred_contact_method = row["preferred_contact_method"]&.strip
    if preferred_contact_method.present?
      field_name = ContactMethod.map_common_names_to_fields(preferred_contact_method)
      ContactMethod.where("LOWER(name) = ?", preferred_contact_method.downcase).first_or_create!(name: row["preferred_contact_method"], field: field_name)
    else
      if row["phone"].present? || row["telephone"].present? || row["Telephone"].present? || row["Phone"].present?
        preferred_contact_method_name = "Call"
        field_name = "phone"
      elsif row["email"].present? || row["Email"].present?
        preferred_contact_method_name = "Email"
        field_name = "email"
      else
        preferred_contact_method_name = "Unknown"
        field_name = "phone" # TODO - needs to be SOMEthing
      end
      contact_methods = ContactMethod.method_name(preferred_contact_method_name.downcase.strip) # was hitting Arel error when chaining
      contact_methods = ContactMethod.where(id: contact_methods.pluck(:id))
      contact_methods.first_or_create!(name: preferred_contact_method_name, field: field_name, enabled: true)
    end
  end

  def find_preferred_locale_in_row(row)
    locale_name = row["locale_name"]&.strip
    SystemLocale.where("LOWER(locale_name) = ?", locale_name).first
  end

  def create_person_from_row(row)
    preferred_locale = find_preferred_locale_in_row(row)
    service_area = create_service_area_from_row(row)
    location = create_location_from_row(row, service_area)
    preferred_contact_method = create_contact_method_from_row(row)
    phone = (row["phone"] || row["telephone"] || row["Telephone"] || row["Phone"] || row["Mobile"] || row["mobile"] || row["Cell"] || row["cell"])&.strip
    email = (row["email"] || row["Email"])&.strip
    if preferred_contact_method.name.downcase == 'phone'
      phone ||= "[imported with no phone]"
    end
    if preferred_contact_method.name.downcase == 'email'
      email ||= "ImportedWithNoEmail@example.com"
    end
    Person.where(name: row["Name"]&.strip, email: email&.strip, phone: phone&.strip).
           first_or_create!(preferred_contact_method: preferred_contact_method,
                            service_area: service_area, location: location,
                            skills: row["skills"]&.strip,
                            preferred_locale: preferred_locale&.locale)
  end

  def create_location_from_row(row, service_area)
    if row["Address"].present? || row["City"].present? || row["State"].present? ||
        row["Zip"].present? || row["County"].present? || row["Region"].present? ||
        row["Neighborhood"].present?
      Location.where(street_address: row["Address"]&.strip,
                     city: row["City"]&.strip, state: row["State"]&.strip, zip: row["Zip"]&.strip,
                     county: row["County"]&.strip, region: row["Region"]&.strip,
                     neighborhood: row["Neighborhood"]&.strip).first_or_create!(service_area: service_area)
    end
  end

  def create_service_area_from_row(row)
    if row["service_area_name"].present?
      ServiceArea.where("LOWER(name) = ?", row["service_area_name"]&.strip.downcase).first_or_create!(name: row["service_area_name"]&.strip)
    end
  end

  def create_listings_data_from_row(row, person, created_at)
    listings = []
    categories_cfq = CustomFormQuestion.where(name: @categories_question_name).first_or_create!
    categories = row[@categories_question_name].to_s.strip.split(/[,;]/)
    row_status = row["status"]&.strip

    categories.each do |category|
      listing = Listing.where(person: person,
                              title: "imported #{Time.current}",
                              created_at: created_at).first_or_create! # TODO add descriptions
      categories_cfq.option_list << category unless categories_cfq.tag_list.includes?(category)
      listing.tag_list << category
      categories_cfq.save!
      listing.save!

      create_any_needed_matches(listing, row_status)

      listings << listing
    end
    listings
  end

  def get_system_status(row)
    # STATUSES = ["matched_tentatively", "match_confirmed", "match_completed",
    # "provider_gave_feedback", "receiver_gave_feedback"]
    #
    # offer data has date instead of status
    status = row["status"] || row["Date last used"].present? ? row["Date last used"] : nil

    if Match::STATUSES.include?(status.downcase)
      system_status = status.downcase
    else
      status_is_a_date = (status&.include?("-") || status&.include?("/"))
      if status.downcase == "completed" || status_is_a_date
        system_status = "match_completed"
      elsif status.downcase == "started"
        system_status = "match_confirmed"
      elsif status.downcase == "reoccurring"
        system_status = nil # TODO - not sure if these should be nil on import?
      elsif status == nil
        system_status = nil
      else
        raise "what's your status?"
      end
    end
    system_status
  end

  def create_any_needed_matches(listing, status)
    system_status = get_system_status(status)

    type = listing.submission.form_name.include?("request") ? "Ask" : "Offer"

    if system_status != nil
      if type == "Ask"
        match = Match.where(receiver: listing, provider: @organization_listing).first_or_create!
      else
        match = Match.where(provider: listing, receiver: @organization_listing).first_or_create!
      end

      match.status = system_status
      match.save!
    end
  end

  def create_submission_response_from_row(row, question, submission)
    response_value = row[question.name]&.strip
    responses = SubmissionResponse.where(question: question, submission: submission, created_at: created_at)
    if ["Yes", "No", "Maybe"].include?(response_value)
      if responses.none?
        @new_records_count += 1
        response = responses.first_or_create!(string_response: response_value, boolean_response: YAML.load(response_value.to_s))
      else
        response = responses.last
        log = "GOT DUPE"
        puts "#{log} Submission --------#{history_log_name(row)}"
        @dupe_records_count += 1
      end
      question = response.question
      question.input_type = "radio"
      question.save!
    else
      if responses.none?
        @new_records_count += 1
        response = responses.first_or_create!(string_response: response_value, created_by: @current_user, updated_by: @current_user, organization: @current_organization)
      else
        response = responses.last
        log = "GOT DUPE"
        puts "#{log} Submission --------#{history_log_name(row)}"
        @dupe_records_count += 1
      end
    end
    response
  end

  def create_organization_community_resource
    CommunityResource.where(organization: @current_organization).first_or_create!(is_created_by_admin: true, name: "PLACEHOLDER")
  end

  def create_listings_data_from_category_questions(row, person, created_at)

  end

  def process_row(row)
    created_at = parse_date(row["Timestamp"])
    person = create_person_from_row(row) # NOTE: this calls create_location_from_row

    if CustomFormQuestion.translated_name_prefix('offer_category_').any?
      listings = create_listings_data_from_category_questions(row, person, created_at)
    else
      listings = create_listings_data_from_row(row, person, created_at)
    end

    submission = Submission.where(created_at: created_at, person: person, form_name: @form_type).first_or_create!(body: listings.map(&:inspect))
    # add custom form responses to submission
    @custom_form_questions.each do |question|
      create_submission_response_from_row(row, question, submission)
    end
  end

  def history_log_name(row)
    " +++ submission created at: " + row["Timestamp"].to_s
  end
end

## ID,
## Organizer,
## Status,

## Name,
## Timestamp,
## Address,
## email,
## telephone,

### Does your request need to remain anonymous? ,
### Number of people in household ,
### "Is a member of your household over the age of 50,
###  or otherwise at elevated risk? ",
### What do you need? Check all that apply,
### Is your need:,
### Add any details about your request,
### Is your need recurring?,
### Organizer Results and Comments



## ID
# Organizer/notes
## Timestamp
## Name
# Waiver
# Date last used
## Telephone
## Email
# Do you wish to be contacted about donations that are needed to support mutual aid work around COVID-19?
# Would you like to be contacted about volunteer opportunities...?
# What resources can you offer? check all applicable
# Do you have special skills or particular resources you would like us to know about?
# Are there any notes about what you've offered above?
