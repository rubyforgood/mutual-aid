class GlossaryController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index; end
end
