class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_subs, only: [:create, :new, :edit]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def show
  end

  def new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    if post.save
      redirect_to post_url(post)
    else
      # fail
      flash.now[:errors] = post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def set_subs
    @subs = Sub.all
  end
end
