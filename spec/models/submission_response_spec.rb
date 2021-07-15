# frozen_string_literal

require 'rails_helper'

RSpec.describe SubmissionResponse, type: :model do
  describe '#name' do
    let(:inputs) do
      {
        string_response: nil,
        text_response: nil,
        boolean_response: nil,
        integer_response: nil,
        array_response: nil,
        date_response: nil,
        datetime_response: nil
      }
    end

    subject { (build :submission_response, **inputs).name }

    context 'with a string response' do
      before { inputs[:string_response] = 'stringy!' }

      it { is_expected.to eq 'stringy!' }
    end

    context 'with a boolean response' do
      before { inputs[:boolean_response] = true }

      it { is_expected.to eq 'true' }
    end

    context 'with an array response' do
      before { inputs[:array_response] = %w[two responses] }

      it { is_expected.to eq 'two, responses' }
    end

    context 'with a date response' do
      before { inputs[:date_response] = Date.new(2020, 4, 1) }

      it { is_expected.to eq '2020-04-01' }
    end

    context 'with a datetime response' do
      before { inputs[:datetime_response] = DateTime.new(2020, 4, 1, 15, 33) }

      it { is_expected.to eq '2020-04-01 @ 3:33pm' }
    end
  end
end
