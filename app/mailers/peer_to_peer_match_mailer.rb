class PeerToPeerMatchMailer < ApplicationMailer
  def peer_to_peer_email(contribution)
    mail(to: contribution.person.email,
        subject: "Peer to peer email")
  end
end
