# This model could be thought of "snapshot" of the orders
# The objects are created for each item entry in the order to ensure the immutability of the information of the order
# This way, even if the items are deleted and modified, the order information will remain the same
class OrderItem < ActiveRecord::Base

  # This will ensure that these attributes will not be modified after the creation of the object
  attr_readonly :name, :price, :quantity, :keeper_id, :item_id, :order_id

  belongs_to :order

  # Constructor of the OrderItem object. All the attributes are set only through this method once.
  def initialize(name,price,quantity,keeper_id,item_id,order_id)
    super()
    self.name=name
    self.price=price
    self.quantity=quantity
    self.keeper_id=keeper_id
    self.item_id=item_id
    self.order_id = order_id
  end

end
