# frozen_string_literal: true

class ActivitiesController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      flash[:success] = 'Activity created!'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @activitiy.destroy
    flash[:success] = 'Activity deleted'
    redirect_to request.referrer || root_url
  end

  private

  def activity_params
    params.require(:activity).permit(:title, :category)
  end

  def correct_user
    @activitiy = current_user.activities.find_by(id: params[:id])
    redirect_to root_url if @activitiy.nil?
  end
end
