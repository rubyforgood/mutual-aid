require 'rails_helper'

RSpec.describe EmailValidator do
  describe 'Email validation' do
    let(:validator) { EmailValidator.new({fields: fields}) }
    let(:fields) { [:email] }
    let(:errors) { double('ActiveModel::Errors') }

    context 'when only one mail is set' do
      it 'should validate valid address' do
        person = double('model', errors: errors, email: 'valid_email@test.org')
        expect(errors).not_to receive(:add)
        validator.validate(person)
      end

      it 'should find an error when the address is invalid' do
        person = double('model', errors: errors, email: 'invalid@missingtld')
        expect(errors).to receive(:add).with(:email, "is not valid")
        validator.validate(person)
      end
    end

    context 'when the two mails are set' do
      let(:fields) { [:email, :email_2] }

      it 'should find an error in email and email_2' do
        person = double('model', errors: errors, email: 'invalid@missingtld', email_2: 'invalid_2@missingtld')
        expect(errors).to receive(:add).twice
        validator.validate(person)
      end

      it 'should find an error only in email' do
        person = double('model', errors: errors, email: 'invalid@missingtld', email_2: 'valid@test.org')
        expect(errors).to receive(:add).once
        validator.validate(person)
      end
    end
  end
end
