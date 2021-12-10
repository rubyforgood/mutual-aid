require 'rails_helper'

RSpec.describe CommunityResource, type: :model do
  describe "community resource can have multiple service areas" do
    it "has many service areas" do
      should respond_to(:service_areas)
    end
    it "should not belong to a single service area" do
      should_not respond_to(:service_area)
    end
  end

  describe "validation" do
    it "can be valid" do
      expect(build(:community_resource)).to be_valid
    end

    it "is invalid if missing a service area" do
      subject = build(:community_resource)
      subject.service_areas = []
      expect(subject).to_not be_valid
    end

    it "is invalid if missing a tag" do
      subject.tag_list = []
      expect(subject).to_not be_valid
    end
  end
end
