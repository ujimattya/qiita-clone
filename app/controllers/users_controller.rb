class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit,:update]
  before_action :correct_user, only: [:edit,:update]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def index
    @users = User.paginate(page: params[:page] )
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    
    if @user.save
      log_in @user
      flash[:success] = "ようこそQiitaCloneへ！"
      redirect_to @user
      
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
      flash[:success] = "変更を保存しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page])
    counts(@user)
  end
  
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :profile)
    end
    
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインが必要です"
        redirect_to login_url
      end
    end
    
    #正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
