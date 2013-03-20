class List < ActiveRecord::Base
  attr_accessible :user_id, :name, :privacy, :desc

  belongs_to :user

  # List objects form many-to-many association with item objects.
  # This association is made possible through intermediate model called "ListItem"
  has_many :items, :through => :list_items
  has_many :list_items

  # Define constant for privacy settings
  def self.PRIVACY_PUBLIC
    0
  end

  # Define constant for privacy settings
  def self.PRIVACY_PRIVATE
    1
  end

  # This will import all the items in the list to the user's cart.
  def import_to_cart()

    cart = List.find(self.id).user.cart
    list_item=List.find(self.id).list_items.all

    #Importing the list will delete all the existing items in the cart
    cart.clear_cart

    list_item.each do |item|
      cart.cart_items.build(:item_id => item.item_id, :quantity => item.quantity)
    end
    cart.save
  end



end
