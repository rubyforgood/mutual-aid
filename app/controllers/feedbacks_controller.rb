# frozen_string_literal: true

# FIXME: Will need to become a mixed-access controller when we add functionality for
# neigbhors to create feedback. Maybe also consider renaming (MatchFeedback)?
class FeedbacksController < AdminController
  before_action :set_feedback, only: %i[show edit update destroy]

  def index
    @feedbacks = Feedback.all
  end

  def show; end

  def new
    @feedback = Feedback.new
  end

  def edit; end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to feedbacks_path, notice: 'Feedback was successfully created.'
    else
      render :new
    end
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to feedbacks_path, notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end

  private

    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def feedback_params
      params.require(:feedback).permit(:match_id, :is_from_receiver, :completed, :quality, :description)
    end
end
