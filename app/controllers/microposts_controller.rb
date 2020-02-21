# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :correct_activity, only: %i[start destroy]
  def start
    @activity = Activity.find(params[:id])
    @micropost = @activity.microposts.create
    @micropost.start_at = Time.now
    @micropost.memo = '#今日の積み立て'
    @micropost.act_itvl = 0
    @micropost.save
  end

  def finish
    @micropost = Micropost.find(params[:id])
    @micropost.update(memo: params[:micropost][:memo])
    @micropost.finish_at = Time.now
    @micropost.act_itvl = Time.at(@micropost.finish_at - @micropost.start_at).utc.strftime('%X')
    if @micropost.save
      flash[:success] = '活動を記録しました'
      # redirect_to current_user
    else
      render 'static_pages/home'
    end
  end

  def tweet
    put('tweet_action追加')
  end

  def delete; end

  def ebit; end

  private

  def correct_activity
    # @micropost = correct_activity.microposts.find_by(id: params[:id])
    # redirect_to root_url if @micropost.nil?
  end
end
