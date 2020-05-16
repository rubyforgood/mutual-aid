class Importers::SubmissionResponseImporter < Importers::BaseImporter

  def initialize(current_user, form_type, categories_question_name=nil)
    # require "#{Rails.root}/db/scripts/tuple_counts.rb" # TODO
    # audit_info(current_user) # TODO
    set_klasses
    establish_counts

    @current_user = current_user
    @custom_form_questions = []
    @form_type = form_type
    @categories_question_name = categories_question_name || "What do you need? Check all that apply,"
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
      question = CustomFormQuestion.where(name: header_name, form_type: @form_type).first_or_create!(display_order: idx, input_type: "string")
      question.update_attributes!(display_order: idx, input_type: "string") # in case question was already in db
      question.save!
      @custom_form_questions << question
    end
  end

  def create_contact_method_from_row(row)
    if row["email"].present?
      preferred_contact_method_name = "Email"
      field_name = "email"
    elsif row["phone"].present?
      preferred_contact_method_name = "Call"
      field_name = "phone"
    else
      preferred_contact_method_name = "Unknown"
      field_name = nil
    end
    ContactMethod.where("LOWER(name) = ?", preferred_contact_method_name.downcase).first_or_create!(name: preferred_contact_method_name, field_name: field_name)
  end

  def create_person_from_row(row)
    location = create_location_from_row(row)
    preferred_contact_method = create_contact_method_from_row(row)
    phone = nil
    email = nil
    if preferred_contact_method&.name.downcase == "IDK".downcase
      phone = row["telephone"] || "UNKNOWN PHONE"
    elsif preferred_contact_method&.name.downcase == "email"
      email = row["email"] || "ImportedWithNoEmail@example.com"
    elsif preferred_contact_method&.name.downcase == "call"
      phone = row["telephone"] || "[imported with no phone]"
    end
    Person.where(name: row["Name"], email: email, phone: phone, location: location).first_or_create!(preferred_contact_method: preferred_contact_method)
  end

  def create_location_from_row(row)
    Location.where(street_address: row["Address"],
                   city: row["City"], state: row["State"], zip: row["Zip"],
                   county: row["Count"], region: row["Region"],
                   neighborhood: row["Neighborhood"]).first_or_create!
  end

  def create_listing_data_from_row(row, person, created_at)
    cfq = CustomFormQuestion.where(name: @categories_question_name).first_or_create!
    categories = row[@categories_question_name].to_s.split(";")
    listing = Listing.where(person: person,
                            title: "#{TBD}",
                            created_at: created_at).first_or_create!(description: row["status"]) # TODO - ok to import status -> description ?

    categories.each do |category|
      cfq.option_list << category unless cfq.tag_list.includes?(category)
      listing.tag_list << category
    end
    cfq.save!
    listing.save!
    listing
  end

  def process_row(row)
    created_at = parse_date(row["Timestamp"])
    person = create_person_from_row(row) # NOTE: this calls create_location_from_row
    listing = create_listing_data_from_row(row, person, created_at)

    submission = Submission.where(created_at: created_at, person: person, form_name: @form_type).first_or_create!(body: listing.inspect)

    @custom_form_questions.each do |question|
      response_value = row[question.name]
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
    end
  end

  def history_log_name(row)
    " +++ submission created at: " + row["Timestamp"].to_s
  end
end

# ID,
# Organizer,
# Status,

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
