class ListsController < ApplicationController

  # Authorize shoppers for actions related to lists. Only shoppers can modify the lists
  before_filter :authorize_shopper, :only => [:new, :destroy, :edit, :update, :add_item, :update_item_quantity,:import_to_cart]

  def new
    @list=List.new
  end

  def create
    @list=current_user.lists.build(params[:list])
    if @list.save
      redirect_to lists_path, :notice => "New List"
    else
    end
  end

  # Let the shopper search for other user's shopping lists by email address
  def search
    user = User.where(:email => params[:search_data]).first

    if user #if such user exists
      redirect_to list_others_path(user.id)
    else #if such user doesn't exist
      redirect_to lists_path, :notice => "Couldn't find anyone"
    end
  end

  # shows the public list of the other user
  def others
    @lists=List.where(:user_id => params[:id], :privacy => List.PRIVACY_PUBLIC)
  end

  def index
    @public_lists=List.where(:user_id => current_user.id, :privacy => List.PRIVACY_PUBLIC)
    @private_lists=List.where(:user_id => current_user.id, :privacy => List.PRIVACY_PRIVATE)
  end

  # shows the list of corresponding params[:id]
  def show
    @list=List.find(params[:id])

    #If the specified list is private and other users try to access it through direct URL, the access will get denied
    if @list.privacy==List.PRIVACY_PRIVATE && @list.user.id!=current_user.id
      if current_user.status==User.STATUS_SHOPPER
        redirect_to lists_path, :notice => "The list is private!"
      else
        redirect_to items_path, :notice => "The list is private!"
      end
    end

  end

  # Delete the list
  def destroy
    @list=List.find(params[:id])
    list_items=ListItem.where(:list_id => @list.id)

    # Upon deleting the list, all the corresponding entries in list_items should also be removed
    list_items.each do |items|
      items.destroy
    end
    @list.destroy

    redirect_to lists_path :notice => "Successfully deleted!!"
  end

  def edit
    @list=List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    if list.update_attributes(params[:list])
      redirect_to list_path(list.id)
    else
      render action: "edit"
    end
  end

  # Add item to the selected list
  def add_item

    # If the user pressed "Add to Cart" without selecting a list
    if params[:list_num]==""
      redirect_to items_path, :notice => "Select a List!!!"
    else
      list_item=ListItem.where(:list_id=>params[:list_num], :item_id=>params[:id]).first_or_create
      redirect_to items_path, :notice=>"ADDED ITEM To The LIST!!"
    end
  end

  # Update item to the selected list
  def update_item_quantity

    # if the quantity is below 0, display notice that it's invalid quantity
    if params[:quantity].to_i < 0
      redirect_to list_path(params[:list_num]), :notice => "Invalid Quantity!"

    # if the quantity is set to 0, remove the item from the list
    elsif params[:quantity].to_i == 0
      redirect_to list_remove_item_path(:num => params[:list_num], :id => params[:id])

    # Else, update the quantity
    else
      l=ListItem.where(:list_id => params[:list_num], :item_id=>params[:id]).first_or_create
      l.update_quantity(params[:quantity])
      redirect_to list_path(params[:list_num]), :notice=>"Successfully updated!!"
    end
  end

  # Imports the whole list into the cart object. Existing items in the carts will be removed.
  def import_to_cart
    list=List.find(params[:id])
    list.import_to_cart
    redirect_to carts_path
  end

  # This method allows the shopper to remove unwanted items from the list
  def remove_item
    list_item=ListItem.where(:list_id=>params[:num], :item_id=>params[:id]).first
    list_item.destroy
    redirect_to list_path(params[:num])
  end


end
