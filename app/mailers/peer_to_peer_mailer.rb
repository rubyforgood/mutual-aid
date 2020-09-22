# frozen_string_literal: true

require "#{Rails.root}/app/helpers/application_helper.rb"
include ApplicationHelper

class PeerToPeerMailer < ApplicationMailer
  def peer_to_peer_email
    if SystemSetting.peer_to_peer?
      #send email
    else
      Rails.logger.info("Email could not be sent")
    end
  end
end