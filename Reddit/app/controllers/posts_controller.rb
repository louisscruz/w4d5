class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
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

  def upvote
    vote = Vote.new(author: current_user, value: 1, votable: @post)
    if vote.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
  end

  def downvote
    vote = Vote.new(author: current_user, value: -1, votable: @post)
    if vote.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
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
