require 'rails_helper'

RSpec.describe NavbarVisibility do
  context "when the settings are 'on' to displaying the navbar" do
    let(:display_navbar) { true }

    it "should return true for the pages where the navbar can be hidden" do
      subject::NAVBAR_HIDEABLE.each do |controller, actions|
        actions.each { |action| expect(subject.shown?(controller, action, display_navbar)).to eq(true) }
      end
    end

    it "should return true for the pages not concerned by the displaying option" do
      expect(subject.shown?('always_displayed_controller', 'index', display_navbar))
    end
  end

  context "when the settings are 'off' to displaying the navbar" do
    let(:display_navbar) { false }

    it "should return false for the pages where the navbar can be hidden" do
      subject::NAVBAR_HIDEABLE.each do |controller, actions|
        actions.each { |action| expect(subject.shown?(controller, action, display_navbar)).to eq(false) }
      end
    end

    it "should return true for the pages not concerned by the displaying option" do
      expect(subject.shown?('always_displayed_controller', 'index', display_navbar))
    end
  end
end
