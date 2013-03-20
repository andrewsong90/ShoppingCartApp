class Item < ActiveRecord::Base
  attr_accessible :desc, :name, :price, :keeper_id, :inStock, :category_id


  # Item objects form many-to-many association with cart objects.
  # This association is made possible through intermediate model called "CartItem"
  has_many :cart_items
  has_many :carts, :through => :cart_items

  # Item objects also form many-to-many association with list objects.
  # This association is made possible through intermediate model called "ListItem"
  has_many :list_items
  has_many :lists, :through => :list_items

  belongs_to :category

  # This method checks whether the requested items in the order are out of stock or not
  def self.check_validity(elements)
    # This array holds items that are low in stock
    out_of_stock_items=Array.new

    # Scan through the item list to check if any of the items are in low stock
    elements.each do |element|
      item=Item.find(element.item_id)
      if (item.inStock - element.quantity) < 0
        out_of_stock_items.push(element.item_id)
      end
    end

    # This array will contain items that are out of stock; it will be empty otherwise
    out_of_stock_items
  end


  # After the validation check has passed, this method will actually record changes in sales and stocks.
  def self.save_sales(elements)
    #if every item is in stock, update the sales and stock quantities
      elements.each do |element|
        item=Item.find(element.item_id)
        item.sales += element.quantity
        item.inStock -= element.quantity
        item.save
      end
    return nil
  end


  # This method displays which items are low in stock
  def self.show_low_stock_message(list)
    display="The current stock for"
    list.each do |item_id|
      item=Item.find(item_id)
      display<< " #{item.name} : #{item.inStock},"
    end
    display.chop << " !"
  end

end
