class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def index
    if params[:tag]
      @microposts = Micropost.tagged_with(params[:tag])
    else
      @microposts = Micropost.order('created_at DESC').page(params[:page])
    end
    # (params[:q])に検索パラメーターが入り、Micropostテーブルを検索する@searchオブジェクトを生成
    @search = Micropost.ransack(params[:q])
    # 検索結果を表示する@resultsオブジェクトを生成
    @results = @search.result
    @check = params[:q]
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
    @comment = Comment.new
  end

  def new
    if logged_in?
      @micropost = current_user.microposts.build # form_for用
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'レビューの投稿に失敗しました。'
      render 'microposts/new'
    end
  end

  def edit
  end

  def update
    @micropost = Micropost.find(params[:id])
    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
      if @micropost.update(micropost_params)
        flash[:success] = 'レビュー内容を更新しました。'
        redirect_to root_url
      else
        flash.now[:danger] = 'レビューの更新に失敗しました。'
        render :edit
      end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_to root_url
  end

  def search
    #(params[:q])に検索パラメーターが入り、Micropostテーブルを検索する@searchオブジェクトを生成
    @search = Micropost.ransack(params[:q])
    #検索結果を表示する@resultsオブジェクトを生成
    @results = @search.result
  end

  private
  
    def micropost_params
      params.require(:micropost).permit(:content, :image, :remove_image, :tag_list, :bottle_name, :producer, :production_area, :evaluation)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      unless @micropost
        redirect_to root_url
      end
    end
end
