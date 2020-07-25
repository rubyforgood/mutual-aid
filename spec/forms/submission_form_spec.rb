require 'rails_helper'

RSpec.describe SubmissionForm do
  let(:contact_method) { create :contact_method_email }
  let(:location_type)  { create :location_type }
  let(:service_area)   { create :service_area }
  let(:question_1)   { create :custom_form_question }
  let(:question_2)   { create :custom_form_question }

  describe 'creating a new submission' do
    let(:params) {{
      form_name: 'Offer_form',
      privacy_level_requested: 'anyone',
      service_area: service_area.id,
      listing_attributes: {
        type: 'Offer',
        tag_list: ['errands','groceries'],
        description: 'on a quiet day i can hear her breathing',
      },
      location_attributes: {
        id: nil,
        city: 'Anakwashtank',
        state: 'DC', # statehood now!
        location_type: location_type.id
      },
      person_attributes: {
        id: nil,
        preferred_contact_method: contact_method.id,
        email: 'we@together.coop',
        name: 'Harriet Tubman',
      },
      responses_attributes: {
        question_1.id.to_s => "answer 1",
        question_2.id.to_s => "answer 2"
      },
    }}

    subject(:submission) { SubmissionForm.build params }


    it 'builds a Submission instance' do
      expect(submission).to be_a Submission
    end

    it 'populates submission fields' do
      expect(submission.privacy_level_requested).to eq 'anyone'
      expect(submission.form_name).to eq 'Offer_form'
    end

    it 'sets the specified service area' do
      expect(submission.service_area).to eq service_area
    end

    describe 'has_one person' do
      subject(:person) { submission.person }

      it 'builds a Person instance' do
        expect(person).to be_a Person
      end

      it 'populates person fields' do
        expect(person.email).to eq 'we@together.coop'
        expect(person.name).to eq 'Harriet Tubman'
      end

      it 'sets the specified contact method' do
        expect(person.preferred_contact_method).to eq contact_method
      end

      describe 'has_one location' do
        subject(:location) { person.location }

        it 'builds a Location instance' do
          expect(location).to be_a Location
        end

        it 'populates location fields' do
          expect(location.city).to eq 'Anakwashtank'
          expect(location.state).to eq 'DC'
        end

        it 'set the specified location_type' do
          expect(location.location_type).to eq location_type
        end

        context 'which is optional' do
          before do
            params[:location_attributes] = {
              street_address: '',
            }
          end

          it 'allows for the rest of submission to be valid' do
            expect(submission).to be_valid
            expect(submission.person.location).to be_nil
          end
        end
      end
    end

    describe 'has_one listing' do # todo: change this to has_many
      subject(:listing) { submission.listings.first }

      it 'builds a Listing instance' do
        expect(listing).to be_a Listing
      end

      it 'populates listing fields' do
        expect(listing.type).to eq 'Offer'
        expect(listing.description).to eq 'on a quiet day i can hear her breathing'
      end

      it 'populates categories on the listing' do
        expect(listing.tag_list).to eq ['errands', 'groceries']
      end

      it 'points both listing and submission to the same Persion instance' do
        expect(listing.person).to be submission.person
      end

      it 'points both person and listings to the same Location instance' do
        expect(listing.location).to be submission.person.location
      end
    end

    describe 'has_many submission_responses' do
      subject(:submission_responses) { submission.submission_responses }

      it 'builds SubmissionResponses' do
        expect(submission_responses.first.string_response).to eq("answer 1")
      end

      it 'builds SubmissionResponses' do
        expect(submission_responses.length).to eq(2)
      end
    end

    describe 'submission capture' do
      let(:json) { JSON.parse(submission.body) }

      it 'captures all inputs given' do
        expect(json.keys).to contain_exactly(
          'form_name', 'listing_attributes', 'location_attributes',
          'person_attributes', 'responses_attributes', 'privacy_level_requested', 'service_area'
        )
      end

      it 'includes nested attributes' do
        expect(json['listing_attributes'].keys).to contain_exactly('description', 'tag_list', 'type')
      end

      it 'includes values provided' do
        expect(json['location_attributes']['city']).to eq 'Anakwashtank'
      end

      it 'does not serialze whole configuration objects' do
        expect(json['service_area']).to eq service_area.id
        expect(json['location_attributes']['location_type']).to eq location_type.id
      end
    end

    describe 'on save' do
      context 'with valid params' do
        before { submission } # do this first to get accurate tare of record counts

        it 'creates new records for itself and all nested objects' do
          expect { submission.save }
            .to  change(Location,   :count).by(1)
            .and change(Listing,    :count).by(1)
            .and change(Person,     :count).by(1)
            .and change(Submission, :count).by(1)
        end
      end

      context 'with invalid params' do
        before do
          Rails.logger.level = :debug
          params[:person_attributes][:email] = ''
          submission
        end

        it 'does not create any new records' do
          Rails.logger.warn '=' * 80
          expect { submission.save }
            .to  change(Location,   :count).by(0)
            .and change(Listing,    :count).by(0)
            .and change(Person,     :count).by(0)
            .and change(Submission, :count).by(0)
        end

        it 'propogates nested errors up to the submission' do
          submission.save
          expect(submission.errors.messages).to eq 'person.email': ["can't be blank"]
        end
      end
    end
  end

  pending 'updating an existing submission' do
    let(:existing_listing)  { create :offer, state: :unmatched, description: 'keep' }
    let(:existing_location) { create :location, city: 'Chicago', zip: '10101' }
    let(:existing_person)   { create :person, location: existing_location, name: 'old name', email: 'keep@me.org' }

    let(:existing_submission) { create(:submission,
      person: existing_person,
      listings: [existing_listing],
      form_name: 'Offer_form',
      privacy_level_requested: 'volunteers',
    )}
    let(:existing_response) { create :submission_response, submission: existing_submission }

    let(:params) {{
      id: existing_submission.id,
      form_name: 'Ask_form',
      service_area: existing_listing.service_area.id,
      listing_attributes: {
        id: existing_listing.id,
        state: 'matched',
      },
      location_attributes: {
        id: existing_location.id,
        city: 'Shikaakwa',
      },
      person_attributes: {
        id: existing_person.id,
        name: 'new name',
      },
      responses_attributes: {
        existing_response.custom_form_question_id.to_s => "updated answer",
      },
    }}

    let(:submission) { SubmissionForm.build params }

    it 'returns the existing records' do
      expect(submission.listings.first.id).to be existing_listing.id
      expect(submission.submission_responses.first.id).to be existing_response.id
      expect(submission.person.location.id).to be existing_location.id
      expect(submission.person.id).to be existing_person.id
      expect(submission.id).to be existing_submission.id
    end

    it 'applies pending changes to submission and nested objects' do
      expect(submission.submission_responses.first.string_response).to be_changed
      expect(submission.listings.first).to be_changed
      expect(submission.person.location).to be_changed
      expect(submission.person).to be_changed
      expect(submission).to be_changed  # TODO: should submissions be editable?
    end

    it 'applies new values to submission and nested objects' do
      expect(submission.submission_responses.first.state).to eq 'updated answer'
      expect(submission.listings.first.state).to eq 'matched'
      expect(submission.person.location.city).to eq 'Shikaakwa'
      expect(submission.person.name).to eq 'new name'
      expect(submission.form_name).to eq 'Ask_form'
    end

    it 'does not change values that were not given' do
      expect(submission.listings.first.description).to eq 'keep'
      expect(submission.person.location.zip).to eq '10101'
      expect(submission.person.email).to eq 'keep@me.org'
      expect(submission.privacy_level_requested).to eq 'volunteers'
    end

    describe 'with no nested attributes'

    describe 'on save' do
      before { submission }

      it 'does not create any new objects on save' do
        expect { submission.save }
          .to  change(Listing,            :count).by(0)
          .and change(Location,           :count).by(0)
          .and change(Person,             :count).by(0)
          .and change(Submission,         :count).by(0)
          .and change(SubmissionResponse, :count).by(0)
      end
    end
  end
end
