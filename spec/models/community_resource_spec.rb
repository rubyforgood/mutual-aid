require 'rails_helper'

RSpec.describe CommunityResource do
  describe "community resource can have multiple service areas" do
    it "has many service areas" do
      should respond_to(:service_areas)
    end
    it "should not belong to a single service area" do
      should_not respond_to(:service_area)
    end
  end
end