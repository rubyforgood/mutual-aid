# frozen_string_literal: true

class AnnouncementsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show new create]

  layout :determine_layout, only: %i[new show]

  def index
    @announcements = policy_scope(Announcement).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render json: @announcements }
    end
  end

  def show; end
  def new;  end
  def edit; end

  def create
    announcement.assign_attributes permitted_attributes(announcement)
    if announcement.save
      redirect_after_create
    else
      render :new
    end
  end

  def update
    if announcement.update(permitted_attributes announcement)
      redirect_to announcements_path, notice: 'Announcement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    announcement.destroy!
    redirect_to announcements_url, notice: 'Announcement was successfully destroyed.'
  end

  private

    def announcement
      @announcement ||= authorize(params[:id] ? Announcement.find(params[:id]) : Announcement.new)
    end
    helper_method :announcement

    def redirect_after_create
      notice = 'Announcement was successfully submitted.'
      if context.can_admin?
        redirect_to announcements_path, notice: "#{notice} We'll review."
      else
        redirect_to thank_you_path, notice: notice
      end
    end

    def determine_layout
      'without_navbar' unless context.system_settings.display_navbar?
    end
end
