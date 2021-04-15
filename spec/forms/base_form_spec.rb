# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BaseForm do
  describe '#given_inputs' do
    let(:form_class) do
      Class.new(BaseForm) do
        string :string, default: nil
        date   :date, default: nil

        def execute
          [inputs, given_inputs]
        end

        def self.model_name # needed for anonymous classes
          ActiveModel::Name.new(self, nil, "BaseFormSpec")
        end
      end
    end

    let(:result) { form_class.build params }
    let(:inputs) { result[0] }
    let(:given_inputs) { result[1] }

    context 'with no params given' do
      let(:params) { {} }

      it 'recognizes no params were given' do
        expect(inputs).to eq(string: nil, date: nil)
        expect(given_inputs).to be_empty
      end
    end

    context 'with an explicitly nil param' do
      let(:params) { {date: nil} }

      specify 'inputs show all params with defaults' do
        expect(inputs).to eq(string: nil, date: nil)
      end

      specify 'given_inputs only show params that were explicitly given' do
        expect(given_inputs).to eq(date: nil)
      end
    end

    context 'with params given' do
      let(:params) { {string: 'a string', date: '2020-12-31'} }

      it 'recognizes the given params' do
        expect(inputs).to eq(string: 'a string', date: Date.new(2020, 12, 31))
        expect(given_inputs).to eq inputs
      end
    end

    context 'with a complete multi-part date param' do
      let(:params) do
        {
          'date(1i)' => '2020',
          'date(2i)' => '12',
          'date(3i)' => '31'
        }
      end

      it 'recognizes the multi-part date was given' do
        expect(inputs).to eq(string: nil, date: Date.new(2020, 12, 31))
        expect(given_inputs).to eq(date: Date.new(2020, 12, 31))
      end
    end

    context 'with a partial multi-part date param' do
      let(:params) do
        {'date(1i)' => '2020'}
      end

      it 'ignores the date' do
        expect(inputs).to eq(string: nil, date: nil)
        expect(given_inputs).to be_empty
      end
    end
  end

  describe '.filter_keys' do
    let(:form_class) do
      Class.new(BaseForm) do
        array :array
        date  :date
        hash  :raw_hash, strip: false
        hash  :nested_hash do
          date :nested_date
          hash :doubly_nested_hash do
            integer :id
          end
        end

        def self.model_name # needed for anonymous classes
          ActiveModel::Name.new(self, nil, "BaseFormSpec")
        end
      end
    end

    subject(:keys) { form_class.filter_keys }

    it do
      is_expected.to eq [
        :date,
        array: [],
        raw_hash: {},
        nested_hash: [
          :nested_date,
          doubly_nested_hash: [:id],
        ],
      ]
    end
  end
end
