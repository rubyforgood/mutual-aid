# frozen_string_literal: true

class PeerToPeerMatchMailer < ApplicationMailer
  def peer_to_peer_email(contribution, peer_alias:, message:, organization:)
    peer_email_address = contribution.person.email
    subject = email_subject(contribution, peer_alias)

    mail(to: peer_email_address, subject: subject) do |format|
      format.html do
        render locals: {
          contribution: contribution,
          message: message,
          organization: organization,
          peer_email_address: peer_email_address
        }
      end
    end
  end

  private

  def email_subject(contribution, peer_alias)
    if contribution.ask?
      "#{peer_alias} is offering to meet your ask"
    elsif contribution.offer? # TODO: check if community resource when added
      "#{peer_alias} would like to accept your offer"
    end
  end
end
