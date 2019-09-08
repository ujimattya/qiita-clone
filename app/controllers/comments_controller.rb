class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
        flash[:notice] = 'コメントを投稿しました!'
        redirect_to comment.post
    else
      redirect_to root_url
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.post, flash: { notice: 'コメントが削除されました' }
  end
  
  private
    def comment_params
      params.require(:comment).permit(:comment,:post_id,:user_id)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインが必要です"
        redirect_to login_url
      end
    end
end
