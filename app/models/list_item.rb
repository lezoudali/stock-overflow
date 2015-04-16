class ListItem < ActiveRecord::Base
  has_many :lists, :items
end
