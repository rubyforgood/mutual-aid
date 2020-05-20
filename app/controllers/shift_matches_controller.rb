class ShiftMatchesController < ApplicationController
  before_action :set_shift_match, only: [:show, :edit, :update, :destroy]

  def index
    @shift_matches = ShiftMatch.all
  end

  def show
  end

  def new
    @shift_match = ShiftMatch.new
    set_form_dropdowns
  end

  def edit
    set_form_dropdowns
  end

  def create
    @shift_match = ShiftMatch.new(shift_match_params)

    if @shift_match.save
      redirect_to shift_matches_path, notice: 'Shift match was successfully created.'
    else
      set_form_dropdowns
      render :new
    end
  end

  def update
    if @shift_match.update(shift_match_params)
      redirect_to shift_matches_path, notice: 'Shift match was successfully updated.'
    else
      set_form_dropdowns
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

    def set_form_dropdowns
      if action_name == "new"
        @shifts = Shift.active
      else
        @shifts = Shift.all
      end
      @shift_id = Shift.today.where(person_id: params[:person_id]).last&.id if params[:person_id].present?
    end

    def shift_match_params
      params.require(:shift_match).permit(:shift_id, :match_id, :notes)
    end
end
