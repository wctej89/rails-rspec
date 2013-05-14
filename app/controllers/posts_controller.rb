class PostsController < ApplicationController
  # before_filter :authenticate

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  
end
