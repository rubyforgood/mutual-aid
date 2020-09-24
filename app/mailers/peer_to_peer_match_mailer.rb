class PeerToPeerMatchMailer < ApplicationMailer
  def peer_to_peer_email(contribution, peer_to_peer_match_params)
    peer_email_address = contribution.person.email
    peer_alias = peer_to_peer_match_params[:peer_alias]
    email_subject = if contribution.ask?
                "#{peer_alias} is offering to meet your ask"
              elsif contribution.offer? # TODO: check if community resource when added
                "#{peer_alias} would like to accept your offer"
              end
    @email_body = peer_to_peer_match_params[:message]
    mail(to: peer_email_address, subject: email_subject)
  end
end
