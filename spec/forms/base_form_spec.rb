# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BaseForm do
  describe '#given_inputs' do
    let(:form) do
      Class.new(BaseForm) {
        string :string, default: nil
        date   :date, default: nil

        def execute
          [inputs, given_inputs]
        end

        def self.model_name # needed for anonymous classes
          ActiveModel::Name.new(self, nil, "BaseFormSpec")
        end
      }
    end

    let(:result) { form.build params }
    let(:inputs) { result[0] }
    let(:given_inputs) { result[1] }

    context 'with no params given' do
      let(:params) {{}}

      it 'recognizes no params were given' do
        expect(inputs).to eq(string: nil, date: nil)
        expect(given_inputs).to be_empty
      end
    end

    context 'with an explicitly nil param' do
      let(:params) {{ date: nil }}

      specify 'inputs show all params with defaults' do
        expect(inputs).to eq(string: nil, date: nil)
      end

      specify 'given_inputs only show params that were explicitly given' do
        expect(given_inputs).to eq(date: nil)
      end
    end

    context 'with params given' do
      let(:params) {{ string: 'a string', date: '2020-12-31' }}

      it 'recognizes the given params' do
        expect(inputs).to eq(string: 'a string', date: Date.new(2020, 12, 31))
        expect(given_inputs).to eq inputs
      end
    end

    context 'with a complete multi-part date param' do
      let(:params) {{
        'date(1i)' => '2020',
        'date(2i)' => '12',
        'date(3i)' => '31',
      }}

      it 'recognizes the multi-part date was given' do
        expect(inputs).to eq(string: nil, date: Date.new(2020, 12, 31))
        expect(given_inputs).to eq(date: Date.new(2020, 12, 31))
      end
    end

    context 'with a partial multi-part date param' do
      let(:params) {{
        'date(1i)' => '2020',
      }}

      it 'ignores the date' do
        expect(inputs).to eq(string: nil, date: nil)
        expect(given_inputs).to be_empty
      end
    end
  end
end
