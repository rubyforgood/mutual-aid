# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def index
    @users = policy_scope(User).all
  end

  def show
    authorize user
  end

  def new
    authorize user
    set_form_dropdowns
  end

  def edit
    authorize user
    if user == current_user
      redirect_to edit_user_registration_path
    else
      set_form_dropdowns
    end
  end

  def update
    authorize user
    if user.update(permitted_attributes(user))
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    authorize user
    user.destroy
    redirect_to users_path, notice: 'User record was successfully deleted.'
  end

  private

  def user
    @user ||= params[:id] ? User.find(params[:id]) : User.new
  end

  def set_form_dropdowns
    @contact_methods = ContactMethod.enabled # for nested Person
  end

  def user_params
    params.require(:user).permit(permitted_attributes)
  end
end
