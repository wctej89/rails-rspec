class Admin::PostsController < ApplicationController
  # before_filter :authenticate, :only => :index

  def index
    @posts = Post.all
    # render status: 401
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = "Post was successfully saved."
      redirect_to admin_post_url(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to admin_post_url(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:destroy])
    post.destroy

    redirect_to admin_posts_url
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "geek" && password == "jock"
    end
  end
end
