# frozen_string_literal: true

class EmailPeer < ActiveInteraction::Base
  string :peer_alias
  string :message
  object :contribution, class: Listing
  object :organization
  object :user

  def execute
    peer_to_peer_email = PeerToPeerMatchMailer.peer_to_peer_email(
      contribution,
      organization: organization,
      peer_alias: peer_alias,
      message: message
    )

    status = Messenger.new(peer_to_peer_email, 'peer_to_peer_email').deliver_now

    CommunicationLog.log_email(
      email: peer_to_peer_email,
      delivery_status: status,
      person: contribution.person,
      initiator: user
    )
  end
end
