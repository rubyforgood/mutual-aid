require 'rails_helper'

RSpec.describe Importers::CommunityResourceImporter do
  let(:user) { User.new }
  subject { Importers::CommunityResourceImporter.new(user) }

  let(:single_record) {
    <<~CSV
      category_name,name,organization_name,street,city,state,zip,county,service_area_name,service_area_counties,service_area_town_names,phone,website_url,facebook_url,publish_from,publish_until,is_created_by_admin,is_approved,youtube_identifier,description
      food,Food Vouchers,WIC,123 Main Street,Springfield,XY,12345,Queens County,,,,818-555-9876,https://example.com,https://facebook.com/sample,2020-09-05,,TRUE,TRUE,,A long description of text.
    CSV
  }

  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context 'when given a row of csv data' do
    it 'creates a single CommunityResource in the database' do
      expect {
        subject.import_string single_record
      }.to change { CommunityResource.count }.from(0).to(1)
    end

    it 'creates a CommunityResource with a name' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.name).to eq 'Food Vouchers'
    end

    it 'creates a CommunityResource with a website_url' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.website_url).to eq 'https://example.com'
    end

    it 'creates a CommunityResource with a facebook_url' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.facebook_url).to eq 'https://facebook.com/sample'
    end

    it 'creates a CommunityResource with a phone' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.phone).to eq '818-555-9876'
    end

    it 'creates a CommunityResource with a description' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.description).to eq 'A long description of text.'
    end

    it 'creates a CommunityResource with an organization' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.organization.name).to eq "WIC"
    end

    it 'creates a CommunityResource with a business location type' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.location.location_type.name).to eq "business"
    end

    it 'creates a CommunityResource with a location street' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.location.street_address).to eq "123 Main Street"
    end

    it 'creates a CommunityResource with a location city' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.location.city).to eq "Springfield"
    end

    it 'creates a CommunityResource with a location state' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.location.state).to eq "XY"
    end

    it 'creates a CommunityResource with a location zip' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.location.zip).to eq "12345"
    end

    it 'creates a CommunityResource with a location county' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.location.county).to eq "Queens County"
    end

    context "when service area location is not provided" do
      it "sets the service area name from the community resource location" do
        pending "What should the name be set to if it's not provided?"
        subject.import_string single_record
        resource = CommunityResource.last
        expect(resource.service_area.name).to eq "Unknown"
      end

      it "sets the service area location city from the community resource location" do
        subject.import_string single_record
        resource = CommunityResource.last
        expect(resource.service_area.location.city).to eq "Springfield"
      end

      it "sets the service area location state from the community resource location" do
        subject.import_string single_record
        resource = CommunityResource.last
        expect(resource.service_area.location.state).to eq "XY"
      end

      it "sets the service area location county from the community resource location" do
        subject.import_string single_record
        resource = CommunityResource.last
        expect(resource.service_area.location.county).to eq "Queens County"
      end

      it "sets the service area location type" do
        subject.import_string single_record
        resource = CommunityResource.last
        expect(resource.service_area.location.location_type.name).to eq "service_area"
      end
    end

    context "when service area location is provided" do
      let(:single_record_with_service_area) {
        <<~CSV
          category_name,name,organization_name,street,city,state,zip,county,service_area_name,service_area_counties,service_area_town_names,phone,website_url,facebook_url,publish_from,publish_until,is_created_by_admin,is_approved,youtube_identifier,description
          food,Food Vouchers,WIC,123 Main Street,Springfield,XY,12345,Queens County,Sunny Side,"Queens County, Brooklyn",,818-555-9876,https://example.com,https://facebook.com/sample,2020-09-05,,TRUE,TRUE,,A long description of text.
        CSV
      }


    end
  end
end