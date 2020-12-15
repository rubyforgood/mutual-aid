# frozen_string_literal: true

class ClaimsController < ApplicationController
  def new
    contribution = Listing.find(params[:contribution_id])
    if contribution.person&.email.blank?
      flash.now[:alert] = "We are sorry, this contributor hasn't provided
                           an email address yet and can't communicate this way".squish
    end
    render locals: {
      contribution: contribution,
      email: current_person&.email
    }
  end

  def create
    ClaimContribution.run!(
      contribution: params[:contribution_id],
      claim_params: claim_params.to_h,
      current_user: current_user
    )
    redirect_to contribution_path(params[:contribution_id]), notice: 'Claim was successful!'
  end

  private

  def claim_params
    params.require(:claim).permit(:peer_alias, :email, :message)
  end

  def current_person
    current_user.person
  end
end
