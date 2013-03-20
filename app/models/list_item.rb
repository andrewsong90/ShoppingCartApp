# This model serves as the intermediate between lists and items in their many-to-many relationship
# This model keeps track of quantity of the items stored in the list
class ListItem < ActiveRecord::Base
  attr_accessible :quantity, :item_id, :list_id

  belongs_to :list
  belongs_to :item

  # Define constant for priority of the item on the list
  def self.PRIORITY_LOW
    0
  end

  # Define constant for priority of the item on the list
  def self.PRIORITY_MEDIUM
    1
  end

  # Define constant for priority of the item on the list
  def self.PRIORITY_HIGH
    2
  end

  # For UI, this method actually displays the level of priority matching the values of the priority constants.
  def display_priority
    if self.priority == ListItem.PRIORITY_LOW
      "Low"
    elsif self.priority == ListItem.PRIORITY_MEDIUM
      "Medium"
    else
      "High"
    end
  end

  # Update the quantity of item in the list
  def update_quantity(amount)
    self.quantity = amount
    self.save
  end

end
