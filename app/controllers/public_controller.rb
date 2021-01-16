# frozen_string_literal: true

class PublicController < ApplicationController
  include NotUsingPunditYet

  skip_before_action :authenticate_user!
end
