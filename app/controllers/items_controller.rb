class ItemsController < ApplicationController

  # Authorize shopkeepers only for the actions of "edit","destroy", and "new"
  # Shoppers and administrators can use other features
  before_filter :authorize_shopkeeper, :only => [:edit, :destroy, :new]

  def new
    @item=Item.new
    @categories=Category.all
  end

  def index
    @items=Item.all
    @categories=Category.all
    if current_user && current_user.status==User.STATUS_SHOPPER
      @lists=current_user.lists.all
    end
  end

  # This method is very similar to "index" except that it shows items in the selected category
  # GET /items and POST /items were already used by "index" and "create" methods => new action was required.
  def index_categories
    # if user selects "All categories", the blank value will be returned
    if params[:category_num]==""
      redirect_to items_path
    end

    # Only pass items under specific category
    @items=Item.where(:category_id => params[:category_num]).all
    @categories=Category.all
    if current_user && current_user.status==User.STATUS_SHOPPER
      @lists=current_user.lists.all
    end
  end

  def show
    @item=Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @categories=Category.all
  end

  # This method is triggered when the shopkeeper wants to create an item entry
  def create
    @item=Item.new(params[:item])
    if @item.save
      redirect_to root_url, :notice => "Successfully created"
    else
    end
  end

  # This method is triggered when the shopkeeper wants to modify an item entry
  def update
    item = Item.find(params[:id])
    if item.update_attributes(params[:item])
      redirect_to item_path(item.id), notice: "Successfully updated item!"
    else
      render action: "edit"
    end
  end

  # This method is triggered when the shopkeeper wants to take a look at only the items supplied by him
  def myItems
    @items=Item.where(:keeper_id => current_user.id)
  end


  # This method is triggered when the shopkeeper wants to remove an item entry
  def destroy
    @item=Item.find(params[:id])
    @item.destroy

    redirect_to items_path :notice => "Successfully deleted!!"
  end

end
