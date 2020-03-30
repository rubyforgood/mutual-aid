require "rails_helper"

RSpec.describe ListingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/listings").to route_to("listings#index")
    end

    it "routes to #new" do
      expect(get: "/listings/new").to route_to("listings#new")
    end

    it "routes to #show" do
      expect(get: "/listings/1").to route_to("listings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/listings/1/edit").to route_to("listings#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/listings").to route_to("listings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/listings/1").to route_to("listings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/listings/1").to route_to("listings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/listings/1").to route_to("listings#destroy", id: "1")
    end
  end
end
