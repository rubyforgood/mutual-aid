class ContactMethodsController < ApplicationController
  before_action :set_contact_method, only: [:show, :edit, :update, :destroy]

  def index
    @contact_methods = ContactMethod.order(:name)
  end

  def show
  end

  def new
    @contact_method = ContactMethod.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @contact_method = ContactMethod.new(contact_method_params)

    respond_to do |format|
      if @contact_method.save
        format.html { redirect_to contact_methods_path, notice: 'Contact method was successfully created.' }
        format.json { render :show, status: :created, location: @contact_method }
      else
        set_form_dropdowns
        format.html { render :new }
        format.json { render json: @contact_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact_method.update(contact_method_params)
        format.html { redirect_to contact_methods_path, notice: 'Contact method was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact_method }
      else
        set_form_dropdowns
        format.html { render :edit }
        format.json { render json: @contact_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact_method.destroy
    respond_to do |format|
      format.html { redirect_to contact_methods_url, notice: 'Contact method was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_contact_method
      @contact_method = ContactMethod.find(params[:id])
    end

    def set_form_dropdowns
      @fields = ["email", "phone"]
    end

    def contact_method_params
      params.require(:contact_method).permit(:name, :field, :enabled)
    end
end
