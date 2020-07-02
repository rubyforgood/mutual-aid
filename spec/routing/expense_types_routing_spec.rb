require "rails_helper"

RSpec.describe ExpenseTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/expense_types").to route_to("expense_types#index")
    end

    it "routes to #new" do
      expect(get: "/expense_types/new").to route_to("expense_types#new")
    end

    it "routes to #show" do
      expect(get: "/expense_types/1").to route_to("expense_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/expense_types/1/edit").to route_to("expense_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/expense_types").to route_to("expense_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/expense_types/1").to route_to("expense_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/expense_types/1").to route_to("expense_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/expense_types/1").to route_to("expense_types#destroy", id: "1")
    end
  end
end
