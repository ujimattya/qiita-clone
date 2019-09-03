class StaticPagesController < ApplicationController
  def home
    @users = User.paginate(page: params[:page] )
    
    @posts = Post.paginate(page: params[:page] )
  end
end
