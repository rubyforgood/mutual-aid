require 'rails_helper'

RSpec.describe "/history_logs", type: :request do
  # HistoryLog. As you add validations to HistoryLog, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip({ name: "HISTORY LOG", topic: "questions_import"})
  }

  let(:invalid_attributes) {
    skip({ name: nil, topic: "questions_import"})
  }

  describe "GET /index" do
    it "renders a successful response" do
      HistoryLog.create! valid_attributes
      get history_logs_url
      expect(response).to be_successful
    end

    it "renders a unsuccessful response" do
      HistoryLog.create! invalid_attributes
      get history_logs_url
      expect(response).to_not be_successful
    end
  end
end
