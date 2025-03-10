class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy,:edit,:update]
  before_action :correct_user,   only: [:destroy,:edit,:update]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "記事を投稿しました"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "記事が消去されました"
    redirect_to root_url
  end
  
  def show
    @post = Post.find(params[:id])
    # if logged_in?
    #   @user = User.find_by(id: current_user.id)
       @comments = @post.comments
       @comment = Comment.new(post_id: @post.id)
    # end
  end
  
  def edit
     @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "変更を保存しました"
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  def index
    
    @posts = Post.paginate(page: params[:page] )
     
    if params[:tag_name]
      @search_posts = @posts.tagged_with("#{params[:tag_name]}")
    end
  end
  
  def stocks
    @posts = Post.paginate(page: params[:page] )
    @user = User.find_by(id: current_user.id)
    @stocks = Favorite.where(user_id: @user.id)
  end

  
  private
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :tag_list)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
    
     #ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインが必要です"
        redirect_to login_url
      end
    end
  
end
