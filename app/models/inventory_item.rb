class InventoryItem < ActiveRecord::Base
  has_many :items, :inventories
end
