require 'rails_helper'

RSpec.describe Importers::CommunityResourceImporter do
  let(:user) { User.new }
  subject { Importers::CommunityResourceImporter.new(user) }

  let(:single_record) {
    <<~CSV
      category_name,name,organization_name,street,city,state,zip,county,service_area_name,service_area_counties,service_area_town_names,phone,website_url,facebook_url,publish_from,publish_until,is_created_by_admin,is_approved,youtube_identifier,description
      food,Food Vouchers,WIC,123 Main Street,Springfield,XY,12345,Queens County,,,,818-555-9876,https://example.com,https://facebook.com/sample,2020-09-05,2020-09-10,FALSE,FALSE,dQw4w9WgXcQ,A long description of text.
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

    it 'creates a CommunityResource with a youtube identifier' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.youtube_identifier).to eq "dQw4w9WgXcQ"
    end

    it 'creates a CommunityResource with a publish_from' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.publish_from).to eq "2020-09-05".to_date
    end

    it 'creates a CommunityResource with a publish_until' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.publish_until).to eq "2020-09-10".to_date
    end

    it 'creates a CommunityResource with a is_created_by_admin' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.is_created_by_admin).to eq false
    end

    it 'creates a CommunityResource with a is_approved' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.is_approved).to eq false
    end
    

    it 'sets the tag on the Community Resource using the category_name' do
      subject.import_string single_record
      resource = CommunityResource.last
      expect(resource.tag_list).to eq ['food']
    end

    context "when service area location is not provided" do
      it "sets the service area name from the community resource location city" do
        subject.import_string single_record
        resource = CommunityResource.last
        expect(resource.service_area.name).to eq "Springfield"
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

    context "when service area name is provided" do
      let(:single_record_with_service_area) {
        <<~CSV
          category_name,name,organization_name,street,city,state,zip,county,service_area_name,service_area_counties,service_area_town_names,phone,website_url,facebook_url,publish_from,publish_until,is_created_by_admin,is_approved,youtube_identifier,description
          food,Food Vouchers,WIC,123 Main Street,Springfield,XY,12345,Queens County,Sunny Side,,,818-555-9876,https://example.com,https://facebook.com/sample,2020-09-05,,TRUE,TRUE,,A long description of text.
        CSV
      }

      it 'sets the service area name from the service_area_name if it is provided' do
        subject.import_string single_record_with_service_area
        resource = CommunityResource.last

        expect(resource.service_area.name).to eq "Sunny Side"
      end

      it 'sets the service area type' do
        subject.import_string single_record_with_service_area
        resource = CommunityResource.last

        expect(resource.service_area.service_area_type).to eq "city"
      end
    end

    context "when service area town name is provided and service area name is not" do
      let(:single_record_with_service_area_town_name) {
        <<~CSV
          category_name,name,organization_name,street,city,state,zip,county,service_area_name,service_area_counties,service_area_town_names,phone,website_url,facebook_url,publish_from,publish_until,is_created_by_admin,is_approved,youtube_identifier,description
          food,Food Vouchers,WIC,123 Main Street,Springfield,XY,12345,Queens County,,"Queens County, Brooklyn","Glens Falls, Queensbury",818-555-9876,https://example.com,https://facebook.com/sample,2020-09-05,,TRUE,TRUE,,A long description of text.
        CSV
      }

    it 'sets the service area name from the service_area_town_names if service_area_name is not provided' do 
      subject.import_string single_record_with_service_area_town_name
      resource = CommunityResource.last

      expect(resource.service_area.name).to eq "Glens Falls, Queensbury"
    end

    it 'checks to see if service area location city is set to the town names' do
      subject.import_string single_record_with_service_area_town_name
      resource = CommunityResource.last

      expect(resource.service_area.location.city).to eq "Glens Falls, Queensbury"
    end
  end

  context "when service area counties are provided and service area names and town names are not" do
      let(:single_record_with_service_area_counties) {
        <<~CSV
          category_name,name,organization_name,street,city,state,zip,county,service_area_name,service_area_counties,service_area_town_names,phone,website_url,facebook_url,publish_from,publish_until,is_created_by_admin,is_approved,youtube_identifier,description
          food,Food Vouchers,WIC,123 Main Street,Springfield,XY,12345,Queens County,,"Queens County, Brooklyn",,818-555-9876,https://example.com,https://facebook.com/sample,2020-09-05,,TRUE,TRUE,,A long description of text.
        CSV
      }

    it 'sets the service area name from the service_area_counties if service_area_name and service_area_town_names are not provided' do 
      subject.import_string single_record_with_service_area_counties
      resource = CommunityResource.last

      expect(resource.service_area.name).to eq "Queens County, Brooklyn"
    end

    it 'sets the service area location county' do
      subject.import_string single_record_with_service_area_counties
      resource = CommunityResource.last 

      expect(resource.service_area.location.county).to eq "Queens County, Brooklyn"
    end

    it 'sets the service area type to county' do
      subject.import_string single_record_with_service_area_counties
      resource = CommunityResource.last 

      expect(resource.service_area.service_area_type).to eq "county"
    end
  end
  end
end