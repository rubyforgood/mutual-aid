require "rails_helper"

RSpec.describe ShiftMatchesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/shift_matches").to route_to("shift_matches#index")
    end

    it "routes to #new" do
      expect(get: "/shift_matches/new").to route_to("shift_matches#new")
    end

    it "routes to #show" do
      expect(get: "/shift_matches/1").to route_to("shift_matches#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/shift_matches/1/edit").to route_to("shift_matches#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/shift_matches").to route_to("shift_matches#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/shift_matches/1").to route_to("shift_matches#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/shift_matches/1").to route_to("shift_matches#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/shift_matches/1").to route_to("shift_matches#destroy", id: "1")
    end
  end
end
