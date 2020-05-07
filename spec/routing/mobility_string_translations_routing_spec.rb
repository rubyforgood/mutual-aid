require "rails_helper"

RSpec.describe MobilityStringTranslationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/mobility_string_translations").to route_to("mobility_string_translations#index")
    end
  end
end
