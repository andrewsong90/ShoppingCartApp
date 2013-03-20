class OrdersController < ApplicationController

  # Authorize the shoppers to be able to place an order
  before_filter :authorize_shopper, :only => [:new, :confirm]


  # This method will show past orders to a shopper or shopkeeper
  def index

    if current_user.status==User.STATUS_SHOPPER
      @orders=current_user.orders.order("created_at DESC").all
    else
      @orders=Order.order("created_at DESC").all
    end

  end


  # Once the order is finally verified by the shopper, the order is submitted to the database, and the cart is cleared
  # so that the user can use the cart in the future.
  def new

    #Create new order object associated to the user
    order=current_user.orders.build
    order.save

    cart_items=current_user.cart.cart_items.all

    cart_items.each do |cart_item|
      item=Item.find(cart_item.item_id)

      #Create immutable object "OrderItem" that holds everything about the item.
      order_items=OrderItem.new(item.name,item.price,cart_item.quantity,item.keeper_id,item.id,order.id)
      order_items.save
    end

    #Clear cart after placing an order
    current_user.cart.clear_cart

  end

  # This serves two functionalities:
  # 1) The order information undergoes several checks to see if the order is valid (low stock, empty cart)
  # 2) Displays the order information, so the shopper can finally check if the order is correct
  # Validation and confirmation are put in same controller method to ensure that malicious users do not confirm directly
  # without validation
  def confirm
    elements=CartItem.where(:cart_id=>current_user.cart.id)

    # if there are no items in the cart, the order will not be placed
    if elements.length==0
      redirect_to carts_path, :notice => "EMPTY CART!!!"
    end

    # Checks to see if any item in the cart is low in stock. If so, abort. If not, update the sales, and stock quantity of the items
    out_of_stock_items=Item.check_validity(elements)

    # This actually checks if any items are below stock
    if out_of_stock_items.length!=0
      redirect_to carts_path, :notice => Item.show_low_stock_message(out_of_stock_items)
    else
      # Save the changes in sales and stocks.
      Item.save_sales(elements)
      #after all the validations are processed, the pre-place order view will be rendered
      @item_list=CartItem.where(:cart_id => current_user.cart.id)
    end
  end

end
