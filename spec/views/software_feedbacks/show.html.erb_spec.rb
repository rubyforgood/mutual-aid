require 'rails_helper'

RSpec.describe "software_feedbacks/show", type: :view do
  before(:each) do
    @software_feedback = assign(:software_feedback, SoftwareFeedback.create!(
      created_by: nil,
      feedback_type: "Feedback Type",
      module_name: "Module Name",
      page_url: "Page Url",
      name: "Name",
      urgency: "Urgency",
      urgency_order: 2,
      notes: "Notes",
      completed: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Feedback Type/)
    expect(rendered).to match(/Module Name/)
    expect(rendered).to match(/Page Url/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Urgency/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/false/)
  end
end
