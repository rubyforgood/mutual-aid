class ShiftMatchesController < ApplicationController
  before_action :set_shift_match, only: [:show, :edit, :update, :destroy]

  def index
    @shift_matches = ShiftMatch.all
  end

  def show
  end

  def new
    @shift_match = ShiftMatch.new
  end

  def edit
  end

  def create
    @shift_match = ShiftMatch.new(shift_match_params)

    if @shift_match.save
      redirect_to @shift_match, notice: 'Shift match was successfully created.'
    else
      render :new
    end
  end

  def update
    if @shift_match.update(shift_match_params)
      redirect_to @shift_match, notice: 'Shift match was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shift_match.destroy
    redirect_to shift_matches_url, notice: 'Shift match was successfully destroyed.'
  end

  private
    def set_shift_match
      @shift_match = ShiftMatch.find(params[:id])
    end

    def shift_match_params
      params.require(:shift_match).permit(:shift_id, :match_id, :notes)
    end
end