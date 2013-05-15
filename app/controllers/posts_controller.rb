class PostsController < ApplicationController


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to "/admin/posts/#{@post.id}", notice: "Post was successfully saved."
    else
    end

  end



end
