# Category model is for classifications of items
class Category < ActiveRecord::Base

  attr_accessible :name, :description

  # category contains many items
  has_many :items
end
