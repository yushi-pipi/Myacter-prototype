# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy following followers]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy
  before_action :create_act_defalt_table, only: :destroy

  def index
    # @users = User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @activities = @user.activities.paginate(page: params[:page])
    @microposts = Kaminari.paginate_array(@user.activities.map(&:microposts).flatten.sort { |a, b| a.created_at <=> b.created_at }.reverse).page(params[:page]).per(10)
    @data = Micropost.joins(:activity).where(user_id: params[:id])
    @postdata = @data.pluck('activities.title,microposts.start_at,microposts.finish_at')
    # @postdata = [['yushi', '1994,8,20', '2020,3,11'], ['miki', '1995,11,20', '2020,3,11']]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_act_defolt_table(@user)
      @user.send_activation_email
      flash[:info] = 'メールを送信しました。確認してください。'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :topimage,
                                 :password_confirmation)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
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
