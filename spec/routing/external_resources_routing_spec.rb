require "rails_helper"

RSpec.describe ExternalResourcesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/external_resources").to route_to("external_resources#index")
    end

    it "routes to #new" do
      expect(get: "/external_resources/new").to route_to("external_resources#new")
    end

    it "routes to #show" do
      expect(get: "/external_resources/1").to route_to("external_resources#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/external_resources/1/edit").to route_to("external_resources#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/external_resources").to route_to("external_resources#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/external_resources/1").to route_to("external_resources#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/external_resources/1").to route_to("external_resources#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/external_resources/1").to route_to("external_resources#destroy", id: "1")
    end
  end
end
