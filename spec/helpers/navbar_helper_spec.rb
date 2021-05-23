RSpec.describe NavbarHelper do
  context "when the settings are 'on' to displaying the navbar" do
    let(:settings) { true }

    it "should return true for the pages where the navbar can be hidden" do
      subject.hidden_places.each do |controller, actions|
        actions.each { |action| expect(subject.show_navbar?(controller, action, settings)).to eq(true) }
      end
    end

    it "should return true for the pages not concerned by the displaying option" do
      expect(subject.show_navbar?('always_display', 'the_navbar', settings))
    end
  end

  context "when the settings are 'off' to displaying the navbar" do
    let(:settings) { false }

    it "should return false for the pages where the navbar can be hidden" do
      subject.hidden_places.each do |controller, actions|
        actions.each { |action| expect(subject.show_navbar?(controller, action, settings)).to eq(false) }
      end
    end

    it "should return true for the pages not concerned by the displaying option" do
      expect(subject.show_navbar?('always_display', 'the_navbar', settings))
    end
  end
end
