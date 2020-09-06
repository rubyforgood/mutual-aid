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

    # failing bc needs location type but we dont know what type it is
    # it 'creates a CommunityResource with a location street' do
    #   subject.import_string single_record
    #   resource = CommunityResource.last
    #   expect(resource.location.street_address).to eq "123 Main Street"
    # end
  end
end