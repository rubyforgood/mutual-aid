require 'spec_helper'

using ToBoolean

RSpec.describe ToBoolean do
  describe 'recognized truthy strings' do
    %w[
      true
      truE
      t
      yes
      y
      on
      1
    ].each do |value|
      padded_value = "'#{value}'".ljust(10)

      example "#{padded_value} => true" do
        expect(value.to_boolean).to be true
      end
    end
  end

  describe 'blank strings and nil' do
    example("nil => nil") { expect(nil.to_boolean).to be nil }
    example("' ' => nil") { expect(' '.to_boolean).to be nil }
    example("''  => nil") { expect(''.to_boolean).to  be nil }
  end

  describe 'truthy string with surrounding whitspace' do
    example("'true ' => true") { expect('true '.to_boolean).to be true }
    example("' yes ' => true") { expect(' yes '.to_boolean).to be true }
  end

  describe 'booleans' do
    example('true  => true')  { expect(true.to_boolean).to  be true }
    example('false => false') { expect(false.to_boolean).to be false }
  end

  describe 'symbols' do
    example(':TruE => true')  { expect(:TruE.to_boolean).to be true }
    example(':null => false') { expect(:null.to_boolean).to be false }
  end

  describe 'any other strings' do
    %w[
      unclear
      mistyped
      untrue
      false
      f
      0
      n
      etc
    ].each do |value|
      padded_value = "'#{value}'".ljust(10)

      example "#{padded_value} => false" do
        expect(value.to_boolean).to be false
      end
    end
  end
end
