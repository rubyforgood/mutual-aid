# frozen_string_literal: true

class AdminController < ApplicationController
  include NotUsingPunditYet

  before_action :authenticate_user!
end
