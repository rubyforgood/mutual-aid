class NewUsersController < ApplicationController

  # before_action ensure_admin!

  def new
    @new_user = User.new
    @existing_people_without_users = #something
  end

  def create
    binding.pry
    # is the user there?
      # if so, tell admin this email already has an account

    # if person exists with that email
      # associate the person with the new user

    # if person doesn't exist, then create them and connect to this user

    # if new user, run confirmation email command
    # return to users index
  end
end