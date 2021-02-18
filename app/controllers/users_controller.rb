class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id),notice: 'プロフィールを更新しました。'
    else
      render :edit
    end
  end

  def following
    @user =User.find(params[:id])
    @users =@user.followings.page(params[:page]).per(5)
    render 'index'
  end

  def followers
    @user =User.find(params[:id])
    @users =@user.followers.page(params[:page]).per(5)
    render 'index'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end



end
