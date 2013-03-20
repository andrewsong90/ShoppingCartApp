class SessionsController < ApplicationController

  def new
  end


  # This method authenticates the user login, and assigns a session variable if authenticated
  def create
    user=User.authenticate(params[:email],params[:password])
    if user
      session[:user_id]=user.id
      redirect_to items_path
    else
      flash[:notice] = "Invalid email or password"
      render "new"
    end
  end


  # This method is for when the user logs out.
  def destroy
    session[:user_id]=nil
    redirect_to items_path
  end
end
