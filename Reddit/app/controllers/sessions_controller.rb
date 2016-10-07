class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )
    if user
      login(user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    end
  end

  def destroy
    logout(current_user)
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
