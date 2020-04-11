class AdminController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  def landing_page
  end
end
