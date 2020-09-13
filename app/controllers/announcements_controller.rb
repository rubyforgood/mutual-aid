class AnnouncementsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  layout :determine_layout, only: [:new, :show]

  def index
    @announcements = Announcement.order(created_at: :desc)
  end

  def show
  end

  def new
    @announcement = Announcement.new
  end

  def edit
  end

  def create
    @announcement = Announcement.new(announcement_params)

    if @announcement.save
      redirect_to @admin_status ? announcements_path : contribution_thank_you_path, notice: "Announcement was successfully submitted.#{ " We'll review." unless @admin_status }"
    else
      render :new
    end
  end

  def update
    if @announcement.update(announcement_params)
      redirect_to announcements_path, notice: 'Announcement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    redirect_to announcements_url, notice: 'Announcement was successfully destroyed.'
  end

  private
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    def determine_layout
      "without_navbar" unless @system_setting.display_navbar?
    end

    def announcement_params
      params.require(:announcement).permit(
          :name,
          :description,
          :is_approved,
          :publish_from,
          :publish_until
      )
    end
end
