class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if !user.points 
      user.update(points: 0)
    end
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
  def notSignedIn
    redirect_to root_path
  end

  def show
    @user = current_user
  end
end