# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    auth = request.env['omniauth.auth']
    # Twitterログイン時
    if auth.present?
      user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to root_url
    else # emai時
      @user = User.find_by(email: params[:session][:email].downcase)
      if @user&.authenticate(params[:session][:password])
        if @user.activated?
          log_in @user
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          # redirect_back_or @user
          redirect_to root_url
        else
          message = 'Account not activated. '
          message += 'Check your email for the activation link.'
          flash[:warning] = message
          redirect_to root_url
        end
      else
        # エラーメッセージを作成する
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def create_act_defalt_table
    title = '学習全般'
    category = '学習'
    user.activities.create!(title: title, category: category)
    title = 'プログラミング全般'
    category = 'プログラミング'
    user.activities.create!(title: title, category: category)
    title = '読書全般'
    category = '読書'
    user.activities.create!(title: title, category: category)
    title = 'スポーツ全般'
    category = 'スポーツ'
    user.activities.create!(title: title, category: category)
    title = '音楽全般'
    category = '音楽'
    user.activities.create!(title: title, category: category)
    title = '芸術全般'
    category = '芸術'
    user.activities.create!(title: title, category: category)
  end
end
