class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  helper_method :current_user


  #Helper method  that returns the user object of the currently logged-in user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  # Below are the authorization methods for each status (Shopper, Shopkeeper, and Administrator)
  # before_filter doesn't take methods with arguments (it could but it's really complicated) => DRY principle not followed for the authorization methods

  # Authorizing shopper
  def authorize_shopper
    if session[:user_id]==nil
      redirect_to root_url, :notice => "You are not Logged in!"
    else
      if User.find(session[:user_id]).status!=User.STATUS_SHOPPER
        redirect_to root_url, :notice => "You are not a Shopper!"
      end
    end
  end

  # Authorizing shopkeeper
  def authorize_shopkeeper
    if session[:user_id]==nil
      redirect_to root_url, :notice => "You are not Logged in!"
    else
      if User.find(session[:user_id]).status!=User.STATUS_SHOPKEEPER
        redirect_to root_url, :notice => "You are not a shopkeeper!"
      end
    end
  end

  # Authorizing administrator
  def authorize_administrator
    if session[:user_id]==nil
      redirect_to root_url, :notice => "You are not Logged in!"
    else
      if User.find(session[:user_id]).status!=User.STATUS_ADMINISTRATOR
        redirect_to root_url, :notice => "You are not an Administrator!"
      end
    end
  end


end
