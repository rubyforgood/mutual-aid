# frozen_string_literal: true

class ContactMethodsController < AdminController
  before_action :set_contact_method, only: %i[show edit update destroy]

  def index
    @contact_methods = ContactMethod.order(:name)
  end

  def show; end

  def new
    @contact_method = ContactMethod.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @contact_method = ContactMethod.new(contact_method_params)

    if @contact_method.save
      redirect_to contact_methods_path, notice: 'Contact method was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @contact_method.update(contact_method_params)
      redirect_to contact_methods_path, notice: 'Contact method was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @contact_method.destroy
    redirect_to contact_methods_url, notice: 'Contact method was successfully destroyed.'
  end

  private

    def set_contact_method
      @contact_method = ContactMethod.find(params[:id])
    end

    def set_form_dropdowns
      @fields = ['email', 'phone']
    end

    def contact_method_params
      params.require(:contact_method).permit(:name, :field, :enabled, :icon_class)
    end
end
