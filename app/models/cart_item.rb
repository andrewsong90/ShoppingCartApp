
# This model serves as the intermediate between carts and items in their many-to-many relationship
# This model keeps track of quantity of the items stored in the cart

class CartItem < ActiveRecord::Base
  attr_accessible :cart_id, :item_id, :quantity

  belongs_to :cart
  belongs_to :item

  # This method adds the item of the specified quantity to the cart
  def add_quantity(q)
    self.quantity+=q
    self.save
  end

  # This method updates the quantity of corresponding item in the cart.
  def update_quantity(q)
    self.quantity=q
    self.save
  end

end
