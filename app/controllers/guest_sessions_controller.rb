# frozen_string_literal: true

class GuestSessionsController < ApplicationController
  def create
    user = User.find_by(email: 'guest@sample.jp')
    session[:user_id] = user.id
    flash[:success] = 'ゲストユーザーでログインしました'
    redirect_to root_path(user)
  end
end
