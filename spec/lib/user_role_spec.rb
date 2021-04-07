require "rails_helper"

describe UserRole do
  context "#to_s" do
    it "should return the string representation of a passed role" do
      expect(UserRole.new("neighbor").to_s).to eq("neighbor")
    end
  end
end
