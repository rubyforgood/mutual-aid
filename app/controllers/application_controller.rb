class ApplicationController < ActionController::Base
  helper_method :zip_code

  def zip_code
    @zip_code ||= params[:zip_code]
  end
end
