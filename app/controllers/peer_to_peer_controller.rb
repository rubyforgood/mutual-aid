# frozen_string_literal: true

class PeerToPeerController < ApplicationController
  def send_email
    PeerToPeerMailer.peer_to_peer_email
  end
end