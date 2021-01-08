require 'rails_helper'

RSpec.describe Anonymize do
  describe ".name" do
    it "returns nil when name is blank" do
      expect(Anonymize.name([nil, ""].sample)).to eq(nil)
    end

    it "returns anonymized first name when just first name given" do
      expect(Anonymize.name("John")).to eq("J***")
    end

    it "returns anonymized full name when full name is given" do
      expect(Anonymize.name("John Doe")).to eq("J*** D**")
    end
  end

  describe ".email" do
    it "returns nil when email is blank" do
      expect(Anonymize.email([nil, ""].sample)).to eq(nil)
    end

    it "returns anonymized email when email is given", :aggregate_failures do
      expect(Anonymize.email("john.doe@example.com")).to eq("********@*******.com")
      expect(Anonymize.email("john@example.org")).to eq("****@*******.org")
    end
  end
end
