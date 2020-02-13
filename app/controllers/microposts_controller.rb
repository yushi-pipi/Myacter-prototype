# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :correct_activity, only: %i[start destroy]
  def start
    @activity = Activity.find(params[:id])
    @micropost = @activity.microposts.create
    @micropost.start_at = Time.now
    @micropost.memo = ''
    @micropost.save
  end

  def finish
    @micropost = Micropost.find(params[:id])
    print(@micropost)
    @micropost.finish_at = Time.now
    @micropost.act_itvl = Time.at(@micropost.finish_at - @micropost.start_at).utc.strftime('%X')
    if @micropost.save
      flash[:success] = '活動を記録しました'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def delete; end

  def ebit; end

  private

  def micropost_params
    params.require(:micropost).permit(:memo, :start_at, :finish_at, :act_itvl)
  end

  def correct_activity
    # @micropost = correct_activity.microposts.find_by(id: params[:id])
    # redirect_to root_url if @micropost.nil?
  end
end
