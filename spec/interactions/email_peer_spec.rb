require 'rails_helper'

RSpec.describe EmailPeer do
  let(:user)         { create(:user, :with_person) }
  let(:contribution) { create :listing }
  let(:organization) { build :organization }
  let(:peer_alias)   { "peer_alias" }
  let(:message)      { "contribution P2P message" }

  subject(:interaction) do
    EmailPeer.run!(
      contribution: contribution,
      organization: organization,
      user: user,
      peer_alias: peer_alias,
      message: message
    )
  end

  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:last_log)   { CommunicationLog.last }

  it 'sends an email', :aggregate_failures do
    expect { interaction }.to change(ActionMailer::Base.deliveries, :size).by(1)
    expect(last_email.to).to eq [contribution.person.email]
  end

  it 'creates a CommunicationLog entry', :aggregate_failures do
    expect { interaction }.to change(CommunicationLog, :count).by(1)
    expect(last_log.person).to eq contribution.person
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
      allow(PeerToPeerMatchMailer).to receive(:peer_to_peer_email).and_return(mail)

      interaction
    end

    it 'marks the log entry as failed' do
      expect(last_log.delivery_status).to eq 'error'
    end
  end
end
