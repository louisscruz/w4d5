class SubsController < ApplicationController
  before_action :set_sub, only: [:show, :edit, :update, :destroy ]
  before_action :require_self, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
  end

  def show
  end

  def new
  end

  def create
    subreddit = Sub.new(sub_params)
    subreddit.moderator = current_user
    if subreddit.save
      redirect_to sub_url(subreddit)
    else
      flash.now[:errors] = subreddit.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private

  def set_sub
    @sub = Sub.find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_self
    if !current_user || (current_user.id != @sub.moderator.id)
      flash.now[:errors] = ["Unauthorized"]
      redirect_to sub_url(@sub)
    end
  end
end
