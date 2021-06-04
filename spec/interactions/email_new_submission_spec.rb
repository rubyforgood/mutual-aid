require 'rails_helper'

RSpec.describe EmailNewSubmission do
  let(:user)           { create :user }
  let(:submission)     { create :submission }
  let(:system_setting) { build  :system_setting }
  let(:organization)   { build  :organization }

  subject(:interaction) do
    EmailNewSubmission.run!(
      submission: submission,
      user: user,
      system_setting: system_setting,
      organization: organization
    )
  end

  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:last_log)   { CommunicationLog.last }

  it 'sends an email' do
    expect { interaction }.to change(ActionMailer::Base.deliveries, :size).by(1)
    expect(last_email.to).to eq [submission.person.email]
  end

  it 'creates a CommunicationLog entry' do
    expect { interaction }.to change(CommunicationLog, :count).by(1)
    expect(last_log.person).to eq submission.person
    expect(last_log.created_by).to eq user
  end

  context 'when email delivery succeeds' do
    before { interaction }

    it 'saves the sent status in the log entry' do
      expect(last_log.delivery_status).to eq 'sent'
    end
  end

  context 'when email delivery fails' do
    before do
      mail = double('email', subject: '', html_part: double('html_part', body: ''))
      allow(mail).to receive(:deliver_now).and_raise(Net::SMTPServerBusy)
      allow(SubmissionMailer).to receive(:new_submission_confirmation_email).and_return(mail)

      interaction
    end

    it 'marks the log entry as failed' do
      expect(last_log.delivery_status).to eq 'error'
    end
  end

  context 'when submission is initiated by anonymous user' do
    let(:user) { nil }

    it 'records a log with nil user' do
      expect { interaction }.to change(CommunicationLog, :count).by(1)
      expect(CommunicationLog.last.created_by).to be_nil
    end
  end
end
