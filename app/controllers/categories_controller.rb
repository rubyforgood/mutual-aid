class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @root_categories = Category.roots.includes(:categories).references(:categories).
            order(display_to_public: :desc, display_order: :asc, name: :asc, parent_id: :asc)
  end

  def show
  end

  def new
    @category = Category.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      set_form_dropdowns
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def set_form_dropdowns
      @parent_categories = Category.where.not(id: @category.id).order(:name).map{ |t| [t.name.titleize, t.id] }
    end

    def category_params
      params.require(:category).permit(
          :name,
          :description,
          :display_order,
          :display_to_public,
          :is_created_by_admin,
          :parent_id,
          categories_attributes: [])
    end
end
