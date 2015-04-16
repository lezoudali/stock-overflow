class Inventory < ActiveRecord::Base
  belongs_to :user
  belongs_to :inventory_item
  has_many :items, through: :inventory_item
end
