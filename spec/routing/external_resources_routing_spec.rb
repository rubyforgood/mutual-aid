require "rails_helper"

RSpec.describe CommunityResourcesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/community_resources").to route_to("community_resources#index")
    end

    it "routes to #new" do
      expect(get: "/community_resources/new").to route_to("community_resources#new")
    end

    it "routes to #show" do
      expect(get: "/community_resources/1").to route_to("community_resources#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/community_resources/1/edit").to route_to("community_resources#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/community_resources").to route_to("community_resources#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/community_resources/1").to route_to("community_resources#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/community_resources/1").to route_to("community_resources#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/community_resources/1").to route_to("community_resources#destroy", id: "1")
    end
  end
end
