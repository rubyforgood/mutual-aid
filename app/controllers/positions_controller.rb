# frozen_string_literal: true

class PositionsController < AdminController
  before_action :set_position, only: %i[show edit update destroy]

  def index
    @positions = Position.all
  end

  def show; end

  def new
    @position = Position.new
  end

  def edit; end

  def create
    @position = Position.new(position_params)

    if @position.save
      redirect_to positions_path, notice: 'Position was successfully created.'
    else
      render :new
    end
  end

  def update
    if @position.update(position_params)
      redirect_to positions_path, notice: 'Position was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @position.destroy
    redirect_to positions_url, notice: 'Position was successfully destroyed.'
  end

  private

    def set_position
      @position = Position.find(params[:id])
    end

    def position_params
      params.require(:position).permit(:team_id, :organization_id, :person_id, :position_type, :name, :description, :start_date, :end_date, :is_primary, :notes, :display_on_org_chart)
    end
end
