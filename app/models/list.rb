class List < ActiveRecord::Base
  belongs_to :user
  belongs_to :list_item
  has_many :items, through: :list_item
end
