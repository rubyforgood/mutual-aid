# frozen_string_literal: true

class ShiftsController < AdminController
  before_action :set_shift, only: %i[show edit update destroy]

  def index
    @shifts = Shift.all
  end

  def show; end

  def new
    @shift = Shift.new
  end

  def edit; end

  def create
    @shift = Shift.new(shift_params)

    if @shift.save
      redirect_to shifts_path, notice: 'Shift was successfully created.'
    else
      render :new
    end
  end

  def update
    if @shift.update(shift_params)
      redirect_to shifts_path, notice: 'Shift was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shift.destroy
    redirect_to shifts_url, notice: 'Shift was successfully destroyed.'
  end

  private

    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:person_id, :team_id, :started_at, :ended_at, :notes)
    end
end
