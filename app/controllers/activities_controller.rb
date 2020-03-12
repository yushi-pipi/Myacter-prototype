# frozen_string_literal: true

class ActivitiesController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :currect_user,   only: :destroy

  def create
    @activity = current_user.activities.build(activity_params)
    if @activity.save
      flash[:success] = '新しいアクティビティを作成しました!'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @activity.destroy
    flash[:success] = 'アクティビティを削除しました'
    redirect_to request.referrer || root_url
  end

  private

  def activity_params
    params.require(:activity).permit(:title, :category, :picture)
  end

  def currect_user
    @activity = current_user.activities.find_by(id: params[:id])
    redirect_to root_url if @activity.nil?
  end
end
