# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :currect_user,   only: :destroy

  def start
    @activity = Activity.find(params[:id])
    @micropost = @activity.microposts.create
    # @micropost.user_id = current_user.id
    @micropost.start_at = Time.zone.now
    @micropost.finish_at = Time.zone.now
    @micropost.act_itvl = Time.zone.now
    @micropost.save
  end

  def finish
    @micropost = Micropost.find(params[:id])
    @micropost.update(memo: params[:micropost][:memo])
    @micropost.finish_at = Time.zone.now
    @micropost.act_itvl = Time.at(@micropost.finish_at - @micropost.start_at).utc.strftime('%X')
    if @micropost.save
      if params[:tweet]
        # ログインユーザーのkey,tokenを取得
        # auth = request.env['omniauth.auth']
        client = Twitter::REST::Client.new do |config|
          # applicationの設定
          config.consumer_key         = ENV['TWITTER_API_KEY']
          config.consumer_secret      = ENV['TWITTER_API_SECRET']
          # ユーザー情報の設定
          # byebug
          config.access_token         = current_user.access_token
          config.access_token_secret  = current_user.access_secret
        end
        # Twitter投稿
        tweet_time = '活動時間:' + @micropost.act_itvl.strftime('%-Hh%-Mm%-Ss').to_s
        tweet_memo = params[:micropost][:tweet]
        client.update(tweet_time + "\n" + tweet_memo)
        # redirect_to root_path, notice: 'ツイートしました！'
        flash[:success] = 'ツイートしました！'
        redirect_to current_user
      else
        flash[:success] = '活動を記録しました'
        redirect_to current_user
      end
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'postを削除しました'
    redirect_to request.referrer || root_url
  end

  def ebit; end

  private

  def post_params
    params.require(:micropost).permit(:memo)
  end

  def currect_user
    @micropost = Micropost.joins(:activity).find_by(activities: { user_id: current_user.id }, id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
