class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_search
  
  def set_search
    #@search = Article.search(params[:q])
    @search = Post.ransack(params[:q]) 
    @search_posts = @search.result.page(params[:page])
  end
end
