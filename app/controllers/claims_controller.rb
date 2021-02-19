# frozen_string_literal: true

class ClaimsController < ApplicationController
  before_action { authorize :claim }

  def new
    contribution = Listing.find(params[:contribution_id])
    if contribution.person&.email.blank?
      flash.now[:alert] = "We are sorry, this contributor hasn't provided
                           an email address yet and can't communicate this way".squish
    end
    render locals: {
      contribution: contribution,
      email: current_user.email
    }
  end

  def create
    ClaimContribution.run!(params[:claim].merge(
      contribution: params[:contribution_id],
      current_user: current_user
    ))
    redirect_to contributions_path, notice: 'Claim was successful!'
  end
end