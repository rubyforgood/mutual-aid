require "rails_helper"

RSpec.describe "glossary/index" do
  it "is succesful without requiring login" do
    create(:listing) # Listing for Respond and Triage links

    render

    expect(response).to match /Glossary/
  end
end
