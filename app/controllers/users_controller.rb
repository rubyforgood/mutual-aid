class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    if @user == current_user
      redirect_to edit_user_registration_path
    else
      set_form_dropdowns
    end
  end

  def new # handled by RegistrationsController
    redirect_to new_user_registration_path
  end

  # def create # handled by RegistrationsController
  # end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
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

  def user_params # NOTE: add new params to RegistrationsController as needed
    params.require(:user).permit(:email, person_attributes: [ :id, :name, :email, :phone, :preferred_contact_method_id, :_destroy ] )
  end
end
