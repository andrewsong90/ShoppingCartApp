class UsersController < ApplicationController

  def new
    @user = User.new
  end


  # This method is triggered when a user wants to see his account information.
  def account
    # It is just for rendering the view
  end

  # This method is triggered when a new user signs up
  def create
    @user = User.new(params[:user])
    # Create Cart objects only for the Shoppers
    if @user.status==User.STATUS_SHOPPER
      cart = @user.build_cart
    end

    if @user.save
      redirect_to root_url, :notice=> "Signed up!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # This method is triggered when user updates the account information
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to user_account_path(@user.id), :notice => "Successfully updated Account!"
    else
      render action: "edit"
    end
  end
end
