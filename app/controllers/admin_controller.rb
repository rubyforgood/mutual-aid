class AdminController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  def landing_page
  end

  def yearbook
    @positions = Position.all
  end
end
