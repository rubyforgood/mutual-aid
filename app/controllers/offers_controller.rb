# TODO: Should we be extending from Base? ApplicationController assumes login.
class OffersController < ActionController::Base
  layout 'application'

  def new
  end
end
