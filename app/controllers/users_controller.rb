class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :followings, :followers, :likes, :reverses_of_likes]
  before_action :correct_user, only: [:edit, :update]


  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を更新しました。'
        redirect_to root_url
      else
        flash.now[:danger] = 'ユーザー情報の更新に失敗しました。'
        render :edit
      end
    else
      redirect_to root_url
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end
  
  def unlikes
    @user = User.find(params[:id])
    @reverses_of_likes = @user.unlikes.page(params[:page])
    # counts(@user)
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image, :introduction)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url
      end
    end
end
