# frozen_string_literal: true

class FormsController < AdminController
  before_action :set_form, only: %i[show edit update destroy]

  def index
    @forms = Form.all
  end

  def show; end

  def new
    @form = Form.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @form = Form.new(form_params)

    if @form.save
      redirect_to forms_path, notice: 'Form was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @form.update(form_params)
      redirect_to forms_path, notice: 'Form was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @form.destroy
    respond_to do |format|
      format.html { redirect_to forms_url, notice: 'Form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_form
      @form = Form.find(params[:id])
    end

    def set_form_dropdowns
      @contribution_types = ['Ask', 'Offer', 'CommunityResource']
    end

    def form_params
      params.require(:form).permit(
          :contribution_type_name,
          :display_categories,
          :footer_html,
          :header_html,
          :name,
          :organization_id
      )
    end
end
