class CartsController < ApplicationController

  # Only authorize shoppers to be able to interact with carts
  before_filter :authorize_shopper


  # Display all the items in the user's cart
  def index
    @item_list = current_user.cart.cart_items
    @lists = current_user.lists
  end

  # Triggered when the shopper wants to save the whole cart to a list.
  def save_to_list
    cart = current_user.cart

    # If the user accidentally does not select any lists, display notice
    if params[:list_num]==""
      redirect_to carts_path, :notice => "Select a List!"

    #If the shopper selects a list, save the list to the cart
    else
      cart.save_to_list(params[:list_num])
      redirect_to list_path(params[:list_num])
    end
  end


  # This method allows the shopper to add an item of desired quantity to the cart
  def add_item

    quantity=params[:quantity].to_i

    # if the added quantity is less than or equal to zero, cancel the operation and notify that it's invalid
    if quantity <= 0
      redirect_to items_path, :notice => "Quantity is not correct"
    else   #if the quantity is valid, update the quantity of the item in CartItem database.
      cart_item=current_user.cart.cart_items.where(:item_id => params[:id]).first_or_create
      cart_item.add_quantity(quantity)
      redirect_to items_path
    end
  end

  # Triggered when the user wants to update the quantity of items.
  def update_item

    quantity=params[:quantity].to_i

    # if the added quantity is less than zero, cancel the operation and notify that it's invalid
    if quantity < 0
      redirect_to items_path, :notice => "Quantity is not correct"
    # if the quantity is 0 just remove the item
    elsif quantity == 0
        redirect_to cart_item_remove_path
    else   #if the quantity is valid, update the quantity of the item in CartItem database.
      cart_item=current_user.cart.cart_items.where(:item_id => params[:id]).first_or_create
      cart_item.update_quantity(quantity)
      redirect_to carts_path
    end
  end

  # This method allows the shopper to remove unwanted items from the cart
  def remove_item
    cart_item=CartItem.where(:cart_id=>current_user.cart.id, :item_id=>params[:id]).first
    cart_item.destroy
    redirect_to carts_path
  end

end
