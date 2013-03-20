class Cart < ActiveRecord::Base
  attr_accessible :user_id


  # A cart object belongs to a user object
  belongs_to :user

  # Cart objects form many-to-many association with item objects.
  # This association is made possible through intermediate model called "CartItem"
  has_many :items, :through => :cart_items
  has_many :cart_items

  # When the user places an order, the cart should be cleared for later use.
  def clear_cart
    items=CartItem.where(:cart_id=>self.id)
    items.each do |item|
      item.destroy
    end
  end

  # This will save the current cart to a specified list
  def save_to_list(list_id)
    elements=CartItem.where(:cart_id=>self.id)
    list=List.find(list_id)
    elements.each do |element|
      item=Item.find(element.item_id)
      list.list_items.build(:item_id=>item.id, :quantity=>element.quantity)
    end
    list.save
  end

end
