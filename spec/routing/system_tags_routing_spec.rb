require "rails_helper"

RSpec.describe SystemTagsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/system_tags").to route_to("system_tags#index")
    end

    it "routes to #new" do
      expect(get: "/system_tags/new").to route_to("system_tags#new")
    end

    it "routes to #show" do
      expect(get: "/system_tags/1").to route_to("system_tags#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/system_tags/1/edit").to route_to("system_tags#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/system_tags").to route_to("system_tags#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/system_tags/1").to route_to("system_tags#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/system_tags/1").to route_to("system_tags#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/system_tags/1").to route_to("system_tags#destroy", id: "1")
    end
  end
end
