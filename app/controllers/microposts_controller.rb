# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :correct_activity, only: %i[start destroy]
  def start
    @activity = Activity.find(params[:id])
    @micropost = @activity.microposts.create
    @micropost.start_at = Time.now
    @micropost.finish_at = Time.now
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
        tweet = '活動時間:' + @micropost.act_itvl + '/n'
        tweet += params[:micropost][:memo]
        client.update(tweet)
        # redirect_to root_path, notice: 'ツイートしました！'
        flash[:success] = 'ツイートしました！'
        　else
        flash[:success] = '活動を記録しました'

        redirect_to current_user
      end

    else
      render 'static_pages/home'
    end
  end

  def delete; end

  def ebit; end

  private

  def post_params
    params.require(:micropost).permit(:memo)
  end

  def correct_activity
    # @micropost = correct_activity.microposts.find_by(id: params[:id])
    # redirect_to root_url if @micropost.nil?
  end
end
