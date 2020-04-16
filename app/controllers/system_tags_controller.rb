class SystemTagsController < ApplicationController
  before_action :set_system_tag, only: [:show, :edit, :update, :destroy]

  # GET /system_tags
  # GET /system_tags.json
  def index
    @system_tags = SystemTag.all
  end

  # GET /system_tags/1
  # GET /system_tags/1.json
  def show
  end

  # GET /system_tags/new
  def new
    @system_tag = SystemTag.new
    @parent_system_tags = SystemTag.order(:name).map{ |t| [t.name.titleize + "#{" (subsystem_tag)" if t.system_tags.none?}", t.id] }
  end

  # GET /system_tags/1/edit
  def edit
    @parent_system_tags = SystemTag.order(:name).map{ |t| [t.name.titleize, t.id] }
  end

  # POST /system_tags
  # POST /system_tags.json
  def create
    @system_tag = SystemTag.new(system_tag_params)

    respond_to do |format|
      if @system_tag.save
        format.html { redirect_to system_tags_path, notice: 'SystemTag was successfully created.' }
        format.json { render :show, status: :created, location: @system_tag }
      else
        @parent_system_tags = SystemTag.order(:name).map{ |t| [t.name.titleize, t.id] }
        format.html { render :new }
        format.json { render json: @system_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_tags/1
  # PATCH/PUT /system_tags/1.json
  def update
    respond_to do |format|
      if @system_tag.update(system_tag_params)
        format.html { redirect_to system_tags_path, notice: 'SystemTag was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_tag }
      else
        format.html { render :edit }
        format.json { render json: @system_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_tags/1
  # DELETE /system_tags/1.json
  def destroy
    @system_tag.destroy
    respond_to do |format|
      format.html { redirect_to system_tags_url, notice: 'SystemTag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_tag
      @system_tag = SystemTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def system_tag_params
      params.require(:system_tag).permit(:name, :description, :display_to_public, :display_order, :parent_id, :organization_id, :created_by, system_tags_attributes: [])
    end
end
