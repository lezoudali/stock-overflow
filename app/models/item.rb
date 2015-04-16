class Item < ActiveRecord::Base
  belongs_to :inventory_item
  belongs_to :list_item
  has_many :inventories, through: :inventory_item
  has_many :lists, through: :list_item
end
