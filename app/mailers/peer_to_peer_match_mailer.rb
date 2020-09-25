class PeerToPeerMatchMailer < ApplicationMailer
  def peer_to_peer_email(contribution, peer_alias:, message:)
    peer_email_address = contribution.person.email
    email_subject = if contribution.ask?
                      "#{peer_alias} is offering to meet your ask"
                    elsif contribution.offer? # TODO: check if community resource when added
                      "#{peer_alias} would like to accept your offer"
                    end

    mail(to: peer_email_address, subject: email_subject) do |format|
      format.html { render locals: { message: message } }
    end
  end
end
