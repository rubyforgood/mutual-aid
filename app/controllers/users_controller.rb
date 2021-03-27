# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = policy_scope(User).all
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
    set_form_dropdowns
  end

  def edit
    authorize @user
    if @user == current_user
      redirect_to edit_user_registration_path
    else
      set_form_dropdowns
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_form_dropdowns
    @contact_methods = ContactMethod.enabled # for nested Person
  end

  def user_params
    params.require(:user).permit(:email, person_attributes: %i[id name email phone preferred_contact_method_id _destroy] )
  end
end
